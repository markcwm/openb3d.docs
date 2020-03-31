' colorgrading.bmx
' postprocess effect - render framebuffer to texture for colorgrading (may require GL 3)
' This shows how you can colorgrade a scene in a post process. No need to use special shaders on the objects.
' by GaborD

Strict

Framework Openb3dmax.B3dglgraphics
Import Brl.Random
?Not bmxng
Import Brl.Timer
?bmxng
Import Brl.TimerDefault
?

Local lut_array$[]=["Added contrast", "Warm and crispy", "Filmic", "Bleak future", "Blockbuster", "Thermal vision", "Black and white", "Vintage", ""]

Local width%=DesktopWidth(),height%=DesktopHeight()

Graphics3D width,height

SeedRnd MilliSecs()
ClearTextureFilters

Local PostFx:TRenderPass=New TRenderPass
PostFx.InitSprite() ' init cameras, shaders, etc. - use InitPostFx() to render to framebuffer
PostFx.Activate()

' loading some simple test objects
Local tx1:TTexture = LoadTexture("../media/level/floor.jpg")
Local ground:TMesh = LoadMesh( "../media/level/floor.b3d" )
EntityTexture ground, tx1, 0, 0

Local tx2:TTexture = LoadTexture("../media/level/hw.jpg")
Local obj:TMesh = LoadMesh( "../media/level/head.b3d" )
PositionEntity obj, -1, 0, 0
RotateEntity obj, 0, -59, 0
EntityTexture obj, tx2, 0, 0

Local tx4:TTexture = LoadTexture("../media/level/pic.jpg")
Local pic:TMesh = LoadMesh( "../media/level/pic.b3d" )
EntityTexture pic, tx4, 0, 0
PositionEntity pic, 2.5, 0, -1
RotateEntity pic, 0, -5, 0

' fps code
Local old_ms% = MilliSecs()
Local renders%, fps%

' main loop
While Not KeyHit(KEY_ESCAPE)

	PostFx.PollInput()
	UpdateWorld
	PostFx.Render()
	RenderWorld
	
	' calculate fps
	renders = renders+1
	If MilliSecs()-old_ms>=1000
		old_ms = MilliSecs()
		fps = renders
		renders = 0
	EndIf
	
	Local post$ = "Off"
	If PostFx.Active Then post$ = "On"
	Text 0, 20, "FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0, 40, "Use Space to toggle the post process: "+post$
	Text 0, 60, "Use the arrow keys to switch the used LUT: "+lut_array$[PostFx.Luter]
	
	Flip
	GCCollect
	
Wend

End

Type TRenderPass

	Field Active:Byte=False
	Field Camera:TCamera
	Field PostFx:TPostFX=Null
	Field PostFxCam:TCamera
	Field CameraTex:TTexture
	Field Light:TLight
	Field Sprite:TSprite	
	Field Shader:TShader
	Field Luter# = 0.0  ' Stores which LUT is in use
	Field Tex3:TTexture
	
	Function Create:TRenderPass()
		Return New TRenderPass
	End Function
	
	Method Activate()
		Active=True
	End Method
	
	Method DeActivate()
		Active=False
	End Method
	
	Method InitPostFx()
	
		Camera=CreateCamera()
		CameraRange Camera,0.5,1000.0 ' near must be closer than screen sprite to prevent clipping
		CameraClsColor Camera,150,200,250
		
		Light=CreateLight()
		TurnEntity Light,45,45,0
		
		' the LUT texture we are using, with 8 LUTs
		Tex3=LoadTexture("../media/level/lut.jpg")
		
		Shader=LoadShader("","../glsl/default.vert.glsl", "../glsl/colorgrade.frag.glsl")
		SetInteger(Shader,"texture0",0)
		SetInteger(Shader,"lutMap",1)
		UseFloat(Shader, "luter", Luter)
		
		PostFx=CreatePostFX(Camera,1)
		HideEntity Camera ' note: this boosts framerate as it prevents extra camera render
		
		PositionEntity Camera,0,1.2,0 ' move camera
		MoveEntity Camera,0,0,-3.6
		
		Local pass_no%=0, numColBufs%=1, depth%=0
		Local source_pass%=0, index%=1, slot%=0, frame%=0, value%=1
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		PostFXTexture PostFx,pass_no,Tex3,1,frame
		PostFXShader PostFx,pass_no,Shader
		
	End Method
	
	Method InitSprite() 
	
		Camera=CreateCamera()
		CameraRange Camera,0.5,1000.0 ' near must be closer than screen sprite to prevent clipping
		CameraClsColor Camera,150,200,250
		
		PostFxCam=CreateCamera()
		CameraRange PostFxCam,0.5,1000.0
		CameraClsColor PostFxCam,150,200,250
		HideEntity PostFxCam
		
		' we are not using shaders on objects, so a default light will do
		Light=CreateLight()
		TurnEntity Light,45,45,0
		
		CameraTex=CreateTexture(TGlobal3D.width[0],TGlobal3D.height[0],1+256)
		ScaleTexture CameraTex,1.0,-1.0
		PositionTexture CameraTex,0.0,-1.0
		
		' in GL 2.0 render textures need attached before other textures (EntityTexture)
		CameraToTex CameraTex,Camera
		
		TGlobal3D.CheckFramebufferStatus(GL_FRAMEBUFFER_EXT) ' check for framebuffer errors
		
		Sprite:TSprite=CreateSprite()
		EntityOrder Sprite,-1
		ScaleSprite Sprite,1.0,Float( TGlobal3D.height[0] ) / TGlobal3D.width[0] ' 0.75
		MoveEntity Sprite,0,0,1.0 
		EntityParent Sprite,Camera
		
		PositionEntity PostFxCam,0,1.2,0 ' move camera now sprite is parented to it
		MoveEntity PostFxCam,0,0,-3.6
		
		' the LUT texture we are using, with 8 LUTs
		Tex3=LoadTexture("../media/level/lut.jpg")
		
		' load the post shader and apply it to the screen quad
		Shader=LoadShader("","../glsl/default.vert.glsl", "../glsl/colorgrade.frag.glsl")
		ShaderTexture(Shader, CameraTex, "texture0", 0)
		ShaderTexture(Shader, Tex3, "lutMap", 1)
		UseFloat(Shader, "luter", Luter)
		ShadeEntity(Sprite, Shader)
		
	End Method
	
	Method PollInput()
	
		If PostFx
			PollInputPostFx()
		Else
			PollInputSprite()
		EndIf
		
		' switch LUTs
		If KeyHit(KEY_RIGHT) 
			Luter = Luter+1.0
			If Luter>7 Then Luter = 0.0
		EndIf
		If KeyHit(KEY_LEFT) 
			Luter = Luter-1.0
			If Luter<0 Then Luter = 7
		EndIf
		
	End Method
	
	Method PollInputPostFx()
	
		If KeyHit(KEY_SPACE)
			Active=Not Active
			Local pass_no%=0
			If Active Then PostFXShader PostFx,pass_no,Shader
			If Not Active Then PostFXShader PostFx,pass_no,Null
		EndIf
		
	End Method
	
	Method PollInputSprite()
	
		If KeyHit(KEY_SPACE) Then Active=Not Active
		
		PositionEntity Camera, EntityX(PostFxCam), EntityY(PostFxCam), EntityZ(PostFxCam)
		RotateEntity Camera, EntityPitch(PostFxCam), EntityYaw(PostFxCam), EntityRoll(PostFxCam)
		
	End Method
	
	Method Render()
	
		If Not PostFx Then RenderSprite()
		
	End Method
	
	Method RenderSprite()
	
		PositionEntity PostFxCam,EntityX(Camera),EntityY(Camera),EntityZ(Camera)
		RotateEntity PostFxCam,EntityPitch(Camera),EntityYaw(Camera),EntityRoll(Camera)
		
		If Active=False
			HideEntity PostFxCam
			ShowEntity Camera
			HideEntity Sprite
		Else
			ShowEntity PostFxCam
			HideEntity Camera
			HideEntity Sprite
			
			CameraToTex CameraTex,PostFxCam
			
			HideEntity PostFxCam
			ShowEntity Camera
			ShowEntity Sprite
		EndIf
		
	End Method

End Type
