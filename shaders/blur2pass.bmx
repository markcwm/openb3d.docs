' blur2pass.bmx
' postprocess effect - render framebuffer twice per render for gaussian blur

Strict

Framework Openb3d.B3dglgraphics

?Not bmxng
Import Brl.Timer
Import Brl.Random
?bmxng
Import Brl.TimerDefault
Import Brl.RandomDefault ' since v0.121
?

Local width%=DesktopWidth(),height%=DesktopHeight()

Graphics3D width,height

SeedRnd MilliSecs()
ClearTextureFilters ' remove mipmap flag for postfx texture

Local PostFx:TRenderPass=New TRenderPass
PostFx.InitSprite() ' init cameras, shaders, etc. - use InitPostFx() to render to framebuffer
PostFx.Activate()

Local pivot:TPivot=CreatePivot()
PositionEntity pivot,0,2,0
Local t_sphere:TMesh=CreateSphere( 8 )
EntityShininess t_sphere,0.2
For Local t%=0 To 359 Step 36
	Local sphere:TEntity=CopyMesh(t_sphere,pivot)
	EntityColor sphere,Rnd(256),Rnd(256),Rnd(256)
	TurnEntity sphere,0,t,0
	MoveEntity sphere,0,0,15
Next
FreeEntity t_sphere

Local cube:TMesh=LoadMesh("../media/wcrate1.3ds")
ScaleMesh cube,0.15,0.15,0.15
PositionEntity cube,0,8,0
Local cube_tex:TTexture=LoadTexture("../media/crate.bmp",1+8)
EntityTexture cube,cube_tex

Local cube2:TMesh=CreateCube()
PositionEntity cube2,0,18,0
ScaleEntity cube2,2,2,2
EntityColor cube2,Rnd(256),Rnd(256),Rnd(256)

Local t_cylinder:TMesh=CreateCylinder()
ScaleEntity t_cylinder,0.5,6,0.5
MoveEntity t_cylinder,5,0,-25
For Local t%=0 To 10
	MoveEntity t_cylinder,2,0,9
	Local cylinder:TEntity=CopyMesh(t_cylinder)
	EntityColor cylinder,Rnd(256),Rnd(256),Rnd(256)
Next
FreeEntity t_cylinder

Local ground:TMesh=CreatePlane(128)
Local ground_tex:TTexture=LoadTexture("../media/Envwall.bmp")
ScaleTexture ground_tex,2,2
EntityTexture ground,ground_tex

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
While Not KeyHit(KEY_ESCAPE)

	PostFx.PollInput()
	
	TurnEntity cube,0.1,0.2,0.3
	TurnEntity cube2,0.1,0.2,0.3
	TurnEntity pivot,0,1,0
	
	UpdateWorld
	PostFx.Render()
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"WASD/Arrows: move camera, Space: PostFx.Active = "+PostFx.Active+", L: draw line = "+PostFx.Lflag
	
	Flip
	
Wend

Delay 100 ' try to avoid app hangs
PostFx.DeActivate()
PostFx.Render()

Delay 100
FreeShader PostFx.Shader
FreeShader PostFx.Shader2

End

Type TRenderPass

	Field Active:Byte=False
	Field Camera:TCamera, PostFxCam:TCamera
	Field PostFx:TPostFX=Null
	Field CameraTex:TTexture, CameraTex2:TTexture
	Field Light:TLight
	Field Sprite:TSprite, Sprite2:TSprite
	Field Shader:TShader, Shader2:TShader
	Field Vx_offset#=1.05
	Field Lflag%=0
	
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
		
		Shader=LoadShader("","../glsl/blur.vert.glsl", "../glsl/blurv.frag.glsl")
		SetInteger(Shader,"sceneTex",0)
		SetFloat(Shader,"rt_w", TGlobal3D.width[0])
		SetFloat(Shader,"rt_h", TGlobal3D.height[0])
		UseFloat(Shader,"vx_offset",Vx_offset)
		
		Shader2=LoadShader("","../glsl/blur.vert.glsl", "../glsl/blurh.frag.glsl")
		SetInteger(Shader2,"sceneTex",0)
		SetFloat(Shader2,"rt_w", TGlobal3D.width[0])
		SetFloat(Shader2,"rt_h", TGlobal3D.height[0])
		UseFloat(Shader2,"vx_offset",Vx_offset)
		
		PostFx=CreatePostFX(Camera,2)
		HideEntity Camera ' note: this boosts framerate as it prevents extra camera render
		
		PositionEntity Camera,0,7,0 ' move camera
		MoveEntity Camera,0,0,-25
		
		Local pass_no%=0, numColBufs%=1, depth%=0
		Local source_pass%=0, index%=1, slot%=0, frame%=0
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		PostFXShader PostFx,pass_no,Shader
		
		pass_no=1 ; numColBufs=1 ; depth=0
		source_pass%=1 ; index%=1 ; slot%=0 ; frame=0
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		PostFXShader PostFx,pass_no,Shader2
		
	End Method
	
	Method InitSprite() 
	
		Camera=CreateCamera()
		CameraRange Camera,0.5,1000.0 ' near must be closer than screen sprite to prevent clipping
		CameraClsColor Camera,150,200,250
		
		PostFxCam=CreateCamera()
		CameraRange PostFxCam,0.5,1000.0
		CameraClsColor PostFxCam,150,200,250
		HideEntity PostFxCam
		
		Light=CreateLight()
		TurnEntity Light,45,45,0
		
		CameraTex=CreateTexture(TGlobal3D.width[0],TGlobal3D.height[0],1+256)
		ScaleTexture CameraTex,1.0,-1.0
		PositionTexture CameraTex,0.0,-1.0
		
		CameraTex2=CreateTexture(TGlobal3D.width[0],TGlobal3D.height[0],1+256)
		ScaleTexture CameraTex2,1.0,-1.0
		PositionTexture CameraTex2,0.0,-1.0
		
		' in GL 2.0 render textures need attached before other textures (EntityTexture)
		CameraToTex CameraTex,Camera
		CameraToTex CameraTex2,camera
		
		TGlobal3D.CheckFramebufferStatus(GL_FRAMEBUFFER_EXT) ' check for framebuffer errors
		
		Sprite:TSprite=CreateSprite()
		EntityOrder Sprite,-1
		ScaleSprite Sprite,1.0,Float( TGlobal3D.height[0] ) / TGlobal3D.width[0] ' 0.75
		MoveEntity Sprite,0,0,1.0 
		EntityParent Sprite,Camera
		
		Sprite2:TSprite=CreateSprite()
		EntityOrder Sprite2,-1
		ScaleSprite Sprite2,1.0,Float( TGlobal3D.height[0] ) / TGlobal3D.width[0] ' 0.75
		MoveEntity Sprite2,0,0,1.0 
		EntityParent Sprite2,Camera
		EntityTexture Sprite2,CameraTex2
		
		PositionEntity Camera,0,7,0 ' move camera now sprite is parented to it
		MoveEntity Camera,0,0,-25
		
		Shader=LoadShader("","../glsl/blur.vert.glsl", "../glsl/blurv.frag.glsl")
		ShaderTexture(Shader,CameraTex,"sceneTex",0)
		SetFloat(Shader,"rt_w", TGlobal3D.width[0])
		SetFloat(Shader,"rt_h", TGlobal3D.height[0])
		UseFloat(Shader,"vx_offset",Vx_offset)
		ShadeEntity(Sprite,Shader)
		
		Shader2=LoadShader("","../glsl/blur.vert.glsl", "../glsl/blurh.frag.glsl")
		ShaderTexture(Shader2,CameraTex2,"sceneTex",0)
		SetFloat(Shader2,"rt_w", TGlobal3D.width[0])
		SetFloat(Shader2,"rt_h", TGlobal3D.height[0])
		UseFloat(Shader2,"vx_offset",Vx_offset)
		ShadeEntity(Sprite2,Shader2)
		
	End Method
	
	Method PollInput()
	
		If PostFx
			PollInputPostFx()
		Else
			PollInputSprite()
		EndIf
		
		If KeyHit(KEY_L) Then Lflag=Not Lflag
		If Lflag Then Vx_offset=Float(MouseX())/TGlobal3D.width[0] Else Vx_offset=1.05
		
		' control camera
		MoveEntity Camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
		TurnEntity Camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
		
	End Method
	
	Method PollInputPostFx()
	
		If KeyHit(KEY_SPACE)
			Active:+1
			If Active>3 Then Active=0
			Local pass_no%=0
			If Active=0 Then PostFXShader PostFx,pass_no,Null ; PostFXShader PostFx,pass_no+1,Null
			If Active=1 Then PostFXShader PostFx,pass_no,Shader ; PostFXShader PostFx,pass_no+1,Shader2
			If Active=2 Then PostFXShader PostFx,pass_no,Shader ; PostFXShader PostFx,pass_no+1,Null
			If Active=3 Then PostFXShader PostFx,pass_no,Null ; PostFXShader PostFx,pass_no+1,Shader2
		EndIf
		
	End Method
	
	Method PollInputSprite()
	
		If KeyHit(KEY_SPACE)
			Active:+1
			If Active>3 Then Active=0
		EndIf
		
	End Method
	
	Method Render()
	
		If Not PostFx Then RenderSprite()
		
	End Method
	
	Method RenderSprite()
	
		PositionEntity PostFxCam,EntityX(Camera),EntityY(Camera),EntityZ(Camera)
		RotateEntity PostFxCam,EntityPitch(Camera),EntityYaw(Camera),EntityRoll(Camera)
		
		If Active=0
			HideEntity PostFxCam
			ShowEntity Camera
			HideEntity Sprite2
			HideEntity Sprite
		ElseIf Active=1 ' 2 pass
			ShowEntity PostFxCam
			HideEntity Camera
			HideEntity Sprite2
			HideEntity Sprite
			
			CameraToTex CameraTex,PostFxCam
			
			ShowEntity Sprite
			HideEntity PostFxCam
			ShowEntity Camera ' note: 2nd pass needs main camera
			
			CameraToTex CameraTex2,Camera
			
			HideEntity Sprite
			ShowEntity Sprite2
		ElseIf Active=2 ' shader1
			HideEntity Camera
			ShowEntity PostFxCam
			HideEntity Sprite2
			HideEntity Sprite
			
			CameraToTex CameraTex,PostFxCam
			
			ShowEntity Sprite
			HideEntity PostFxCam
			ShowEntity Camera
		ElseIf Active=3 ' shader2
			HideEntity Camera
			ShowEntity PostFxCam
			HideEntity Sprite2
			HideEntity Sprite
			
			CameraToTex CameraTex2,PostFxCam
			
			ShowEntity Sprite2
			HideEntity PostFxCam
			ShowEntity Camera
		EndIf
		
	End Method

End Type
