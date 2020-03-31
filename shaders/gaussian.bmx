' gaussian.bmx
' postprocess effect - render framebuffer twice per render for gaussian blur
' by Angros

Strict

Framework Openb3dmax.B3dglgraphics

Import Brl.Random
?Not bmxng
Import Brl.Timer
?bmxng
Import Brl.TimerDefault
?

Local width%=DesktopWidth(),height%=DesktopHeight()

Graphics3D width,height,0,2

SeedRnd MilliSecs()
ClearTextureFilters ' remove mipmap flag for postfx texture

Local PostFx:TRenderPass=New TRenderPass
PostFx.InitSprite() ' init cameras, shaders, etc. - use InitPostFx() to render to framebuffer
PostFx.Activate()

Local cube:TMesh=CreateCube()
PostFx.Cube=cube
EntityColor cube,255,0,0

Local plane:TMesh=CreatePlane()
MoveEntity plane,0,-1.4,15

PointEntity PostFx.Light,cube

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
While Not KeyHit(KEY_ESCAPE)

	PostFx.PollInput()
	
	If KeyDown(KEY_UP) Then TurnEntity cube,1,0,0,0
	If KeyDown(KEY_DOWN) Then TurnEntity cube,-1,0,0,0
	If KeyDown(KEY_LEFT) Then TurnEntity cube,0,-1,0,0
	If KeyDown(KEY_RIGHT) Then TurnEntity cube,0,1,0,0
	
	UpdateWorld
	PostFx.Render()
	RenderWorld
	If PostFx.Shadow Then FreeShadow(PostFx.Shadow) ; PostFx.Shadow=Null
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Arrows: turn cube, Space: PostFx.Active = "+PostFx.Active
	
	Flip
	GCCollect
	
Wend

End

Type TRenderPass

	Field Active:Byte=False
	Field Camera:TCamera, PostFxCam:TCamera
	Field PostFx:TPostFX=Null
	Field CameraTex:TTexture, CameraTex2:TTexture
	Field Light:TLight
	Field Sprite:TSprite, Sprite2:TSprite
	Field Shader:TShader, Shader2:TShader
	Field Shadow:TShadowObject
	Field Cube:TMesh
	
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
		CameraClsColor camera,0,0,255
		
		Light=CreateLight()
		
		Shader=LoadShader("gauss","../glsl/gaussian.vert.glsl","../glsl/gaussian.frag.glsl")
		SetInteger(Shader,"RenderTex",0)
		SetInteger(Shader,"Width",TGlobal3D.width[0])
		SetInteger(Shader,"Height",TGlobal3D.height[0])
		
		PostFx=CreatePostFX(Camera,2)
		HideEntity Camera ' note: this boosts framerate as it prevents extra camera render
		
		MoveEntity Light,10,10,-3
		MoveEntity Camera,-2,0,-5
		
		Local pass_no%=0, numColBufs%=1, depth%=0
		Local source_pass%=0, index%=1, slot%=0, frame%=0, value%=1
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		PostFXShader PostFx,pass_no,Shader
		PostFXShaderPass PostFx,pass_no,"PassNum",value
		
		pass_no=1 ; numColBufs=1 ; depth=0
		source_pass%=1 ; index%=1 ; slot%=0 ; frame=0 ; value=2
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		PostFXShader PostFx,pass_no,Shader
		PostFXShaderPass PostFx,pass_no,"PassNum",value
		
	End Method
	
	Method InitSprite() 
	
		Camera=CreateCamera()
		CameraRange Camera,0.5,1000.0 ' near must be closer than screen sprite to prevent clipping
		CameraClsColor Camera,0,0,255
		
		PostFxCam=CreateCamera()
		CameraRange PostFxCam,0.5,1000.0
		CameraClsColor PostFxCam,0,0,255
		HideEntity PostFxCam
		
		Light=CreateLight()
		
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
		
		MoveEntity Light,10,10,-3
		MoveEntity Camera,-2,0,-5
		
		Shader=LoadShader("gauss","../glsl/gaussian.vert.glsl","../glsl/gaussian1.frag.glsl")
		ShaderTexture(Shader,CameraTex,"RenderTex",0)
		SetInteger(Shader,"Width",TGlobal3D.width[0])
		SetInteger(Shader,"Height",TGlobal3D.height[0])
		ShadeEntity(Sprite,Shader)
		
		Shader2=LoadShader("gauss","../glsl/gaussian.vert.glsl","../glsl/gaussian2.frag.glsl")
		ShaderTexture(Shader2,CameraTex2,"RenderTex",0)
		SetInteger(Shader2,"Width",TGlobal3D.width[0])
		SetInteger(Shader2,"Height",TGlobal3D.height[0])
		ShadeEntity(Sprite2,Shader2)
		
	End Method
	
	Method PollInput()
	
		If PostFx
			PollInputPostFx()
		Else
			PollInputSprite()
		EndIf
		
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
	
		If PostFx
			If Shadow=Null Then Shadow=CreateShadow(Cube)
		Else
			RenderSprite()
		EndIf
		
	End Method
	
	Method RenderSprite()
	
		PositionEntity PostFxCam,EntityX(Camera),EntityY(Camera),EntityZ(Camera)
		RotateEntity PostFxCam,EntityPitch(Camera),EntityYaw(Camera),EntityRoll(Camera)
		
		If Active=0
			HideEntity PostFxCam
			ShowEntity Camera
			HideEntity Sprite2
			HideEntity Sprite
			If Shadow=Null Then Shadow=CreateShadow(Cube)
		ElseIf Active=1 ' 2 pass
			ShowEntity PostFxCam
			HideEntity Camera
			HideEntity Sprite2
			HideEntity Sprite
			If Shadow=Null Then Shadow=CreateShadow(Cube)
			
			CameraToTex CameraTex,PostFxCam
			
			If Shadow Then FreeShadow Shadow ; Shadow=Null
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
			If Shadow=Null Then Shadow=CreateShadow(Cube)
			
			CameraToTex CameraTex,PostFxCam
			
			If Shadow Then FreeShadow Shadow ; Shadow=Null
			ShowEntity Sprite
			HideEntity PostFxCam
			ShowEntity Camera
		ElseIf Active=3 ' shader2
			HideEntity Camera
			ShowEntity PostFxCam
			HideEntity Sprite2
			HideEntity Sprite
			If Shadow=Null Then Shadow=CreateShadow(Cube)
			
			CameraToTex CameraTex2,PostFxCam
			
			If Shadow Then FreeShadow Shadow ; Shadow=Null
			ShowEntity Sprite2
			HideEntity PostFxCam
			ShowEntity Camera
		EndIf
		
	End Method

End Type
