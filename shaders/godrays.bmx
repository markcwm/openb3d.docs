' godrays.bmx
' postprocess effect - render framebuffer to texture for God Rays (light scattering)
' by RonTek

Strict

Framework Openb3d.B3dglgraphics

?Not bmxng
Import Brl.Random
?bmxng
Import Brl.RandomDefault ' since v0.121
?

Local width%=DesktopWidth(),height%=DesktopHeight()

Graphics3D width,height,0,2

SeedRnd MilliSecs()
ClearTextureFilters ' remove mipmap flag for postfx texture

Local PostFx:TRenderPass=New TRenderPass
PostFx.InitSprite() ' init cameras, shaders, etc. - use InitPostFx() to render to framebuffer
PostFx.Activate()

AmbientLight 128,128,128

Local brush:TBrush=CreateBrush()

Local sunpivot:TPivot=CreatePivot()

Local lsprite:TSprite=CreateSprite(sunpivot)
EntityColor lsprite,255,255,255
Local spritetex:TTexture=LoadTexture("../media/sunblue.png",2)
EntityTexture lsprite,spritetex
EntityFX(lsprite,32)
EntityOrder lsprite,1
ScaleMesh lsprite,75,75,75
EntityColor lsprite,255,255,127

Local terrain:TMesh=CreateCube()
ScaleEntity terrain,2000,1,2000

' Texture terrain
Local grass_tex:TTexture=LoadTexture( "../media/terrain-1.jpg" )
EntityTexture terrain,grass_tex
ScaleTexture grass_tex,.01,.01

Local cube:TMesh=LoadMesh("../media/castle1.b3d")
PositionEntity cube,0,-5,0
ScaleEntity cube,.5,.5,.5

Local cam_range#=1000.0
MoveEntity lsprite,0,0,cam_range*0.75
RotateEntity sunpivot,-28,-20,0
RotateEntity PostFx.Light,-28,-20,0

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
Local px#, py#, grx#, gry#
Local spx#, spy#, sptime%=0, sunset%=1
While Not KeyHit(KEY_ESCAPE)

	PostFx.PollInput()
	
	If KeyDown(KEY_U)
		TurnEntity sunpivot,-2,0,0
	EndIf
	If KeyDown(KEY_J)
		TurnEntity sunpivot,2,0,0
	EndIf
	If KeyDown(KEY_H)
		TurnEntity sunpivot,0,2,0
	EndIf
	If KeyDown(KEY_K)
		TurnEntity sunpivot,0,-2,0
	EndIf
	
	If KeyHit(KEY_S)
		sunset=Not sunset
	EndIf
	
	If Abs(sptime-MilliSecs())>10 And sunset
		spx=0.01 ' set sun slowly
		spy=0.001
		TurnEntity sunpivot,spx,spy,0
	EndIf
	sptime=MilliSecs()
	
	Local cx#=EntityX(PostFx.Camera)
	Local cy#=EntityY(PostFx.Camera)
	Local cz#=EntityZ(PostFx.Camera)
	sunpivot.PositionEntity(cx,cy,cz)
	PostFx.Light.RotateEntity(-EntityPitch(sunpivot),-EntityYaw(sunpivot),0) ' d-light angles
	
	Local sx#=EntityX(lsprite,True)
	Local sy#=EntityY(lsprite,True)/8.0 ' hack to increase light strength at low angles
	Local sz#=EntityZ(lsprite,True)
	CameraProject(PostFx.Camera,sx,sy,sz)
	
	Local x# = ProjectedX(), y# = ProjectedY()
	px = x
	'y = height-y
	py = y
	grx = px / (width/2.0)
	gry = py / (height/2.0)
	PostFx.GRLightX = grx ' set light position
	PostFx.GRLightY = gry
	
	Local dx# = x - (width/2.0)
	Local dy# = y - (height/2.0)
	Local d# = Sqr(dx*dx + dy*dy) / (height/2.0)
	If d>1 Then d=1
	Local anglenormal# = (180.0 - (180.0 - Abs(Abs(EntityYaw(PostFx.Camera) - EntityYaw(sunpivot)) - 180.0))) / 180.0
	PostFx.GRExp = ((1.0-d)/2.0) + (anglenormal/2.0) ' set ray brightness factor (anglenormal is hack to avoid glare away from sun)
	
	UpdateWorld
	PostFx.Render()
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	BeginMax2D()
	TextColor 0,255,255
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Space: PostFx.Active="+PostFx.Active+", A/Z/Arrows: move/turn camera, U/H/J/K: turn sun, S: set sun="+sunset
	Text 0,60, "GRLightX="+PostFx.GRLightX+" GRLightY="+PostFx.GRLightY+" GRExp="+PostFx.GRExp+" d="+d+" anglenormal="+anglenormal
	Text 0,80,"sunpivot angles="+EntityPitch(sunpivot)+" "+EntityYaw(sunpivot)
	Text 0,100,"light angles="+EntityPitch(PostFx.Light)+" "+EntityYaw(PostFx.Light)
	Text 0,120,"camera angles="+EntityPitch(PostFx.Camera)+" "+EntityYaw(PostFx.Camera)
	EndMax2D()
	
	Flip
	
Wend

Delay 100 ' try to avoid app hangs
PostFx.DeActivate()
PostFx.Render()

Delay 100
FreeShader PostFx.Shader

End

Type TRenderPass

	Field Active:Byte=False
	Field Camera:TCamera, PostFxCam:TCamera
	Field PostFx:TPostFX=Null
	Field CameraTex:TTexture, DepthTex:TTexture
	Field Light:TLight
	Field Sprite:TSprite, Sprite2:TSprite
	Field Shader:TShader
	Field GRExp#, GRLightX#, GRLightY#
	
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
		CameraClsColor Camera,64,128,255
		
		Light=CreateLight()
		'TurnEntity Light,45,45,0
		
		Shader=LoadShader("","../glsl/godrays.vert.glsl", "../glsl/godrays.frag.glsl")
		SetInteger(Shader,"colortex",0) ' Our render texture
		SetInteger(Shader,"depthtex",1) ' 1 is depth texture
		SetInteger(Shader,"Num_Samples",75)
		UseFloat(Shader,"GodRaysExposure",GRExp)
		UseFloat(Shader,"GodRaysLightX",GRLightX)
		UseFloat(Shader,"GodRaysLightY",GRLightY)
		
		PostFx=CreatePostFX(Camera,1)
		HideEntity Camera ' note: this boosts framerate as it prevents extra camera render
		
		PositionEntity Camera,0,20,-15 ' move camera now sprite is parented to it
		RotateEntity Camera,-5,0,0
		
		Local pass_no%=0, numColBufs%=1, depth%=1
		Local source_pass%=0, index%=1, slot%=0
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		index=0 ; slot=1
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		PostFXShader PostFx,pass_no,Shader
		
	End Method
	
	Method InitSprite()
	
		Camera=CreateCamera()
		CameraRange Camera,0.5,1000.0 ' near must be closer than screen sprite to prevent clipping
		CameraClsColor Camera,64,128,255
		
		PostFxCam=CreateCamera()
		CameraRange PostFxCam,0.5,1000.0
		CameraClsColor PostFxCam,64,128,255
		HideEntity PostFxCam
		
		Light=CreateLight()
		'TurnEntity Light,45,45,0
		
		CameraTex=CreateTexture(TGlobal3D.width[0],TGlobal3D.height[0],1+256)
		ScaleTexture CameraTex,1.0,-1.0
		PositionTexture CameraTex,0.0,-1.0
		
		DepthTex=CreateTexture(TGlobal3D.width[0],TGlobal3D.height[0],1+256)
		ScaleTexture DepthTex,1.0,-1.0
		PositionTexture DepthTex,0.0,-1.0
		
		' in GL 2.0 render textures need attached before other textures (EntityTexture)
		CameraToTex CameraTex,Camera
		DepthBufferToTex DepthTex,Camera
		
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
		EntityTexture Sprite2,DepthTex
		
		PositionEntity Camera,0,20,-15 ' move camera now sprite is parented to it
		RotateEntity Camera,-5,0,0
		
		Shader=LoadShader("","../glsl/godrays.vert.glsl", "../glsl/godrays.frag.glsl")
		ShaderTexture(Shader,CameraTex,"colortex",0) ' Our render texture
		ShaderTexture(Shader,DepthTex,"depthtex",1) ' 1 is depth texture
		SetInteger(Shader,"Num_Samples",75)
		UseFloat(Shader,"GodRaysExposure",GRExp)
		UseFloat(Shader,"GodRaysLightX",GRLightX)
		UseFloat(Shader,"GodRaysLightY",GRLightY)
		ShadeEntity(Sprite,Shader)
		
	End Method
	
	Method PollInput()
	
		If PostFx
			PollInputPostFx()
		Else
			PollInputSprite()
		EndIf
			
		' control camera
		If KeyDown( KEY_UP )
			TurnEntity Camera,-3,0,0
		Else If KeyDown( KEY_DOWN )
			TurnEntity Camera,3,0,0
		EndIf 
		If KeyDown( KEY_LEFT )
			TurnEntity Camera,0,3,0
		Else If KeyDown( KEY_RIGHT )
			TurnEntity Camera,0,-3,0
		EndIf
		If KeyDown( KEY_A )
			MoveEntity Camera,0,0,3
		Else If KeyDown( KEY_Z )
			MoveEntity Camera,0,0,-3
		EndIf
		
	End Method
	
	Method PollInputPostFx()
	
		If KeyHit(KEY_SPACE)
			Active=Not Active
			Local pass_no%=0
			If Active=0 Then PostFXShader PostFx,pass_no,Null
			If Active=1 Then PostFXShader PostFx,pass_no,Shader
		EndIf
		
	End Method
	
	Method PollInputSprite()
	
		If KeyHit(KEY_SPACE)
			Active:+1
			If Active>1 Then Active=0
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
			HideEntity Sprite
			HideEntity Sprite2
		ElseIf Active=1 ' 2 pass depth
			HideEntity Camera
			ShowEntity PostFxCam
			HideEntity Sprite2
			HideEntity Sprite
			
			CameraToTex CameraTex,PostFxCam
			
			HideEntity PostFxCam
			ShowEntity Camera
			
			DepthBufferToTex DepthTex,Camera
			
			ShowEntity Sprite
		ElseIf Active=2 ' depth
			HideEntity Camera
			ShowEntity PostFxCam
			HideEntity Sprite2
			HideEntity Sprite
			
			DepthBufferToTex DepthTex,PostFxCam
			
			ShowEntity Sprite2
			HideEntity PostFxCam
			ShowEntity Camera
		EndIf
		
	End Method

End Type
