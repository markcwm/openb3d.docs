' shimmer.bmx
' postprocess effect - render framebuffer to texture for shimmer/heat haze

Strict

Framework Openb3dmax.B3dglgraphics

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
	EntityColor sphere,Float(Rnd(256)),Float(Rnd(256)),Float(Rnd(256))
	TurnEntity sphere,0,t,0
	MoveEntity sphere,0,0,15
Next
FreeEntity t_sphere

Local cube:TMesh=LoadMesh("../media/wcrate1.3ds")
ScaleMesh cube,0.15,0.15,0.15
PositionEntity cube,0,8,0
Local cube_tex:TTexture=LoadTexture("../media/crate.bmp",1)
EntityTexture cube,cube_tex

Local cube2:TMesh=CreateCube()
PositionEntity cube2,0,18,0
ScaleEntity cube2,2,2,2
EntityColor cube2,Float(Rnd(256)),Float(Rnd(256)),Float(Rnd(256))

Local t_cylinder:TMesh=CreateCylinder()
ScaleEntity t_cylinder,0.5,6,0.5
MoveEntity t_cylinder,5,0,-25
For Local t%=0 To 10
	MoveEntity t_cylinder,2,0,9
	Local cylinder:TEntity=CopyMesh(t_cylinder)
	EntityColor cylinder,Float(Rnd(256)),Float(Rnd(256)),Float(Rnd(256))
Next
FreeEntity t_cylinder

Local ground:TMesh=CreatePlane(128)
Local ground_tex:TTexture=LoadTexture("../media/Envwall.bmp",1+8)
ScaleTexture ground_tex,2,2
EntityTexture ground,ground_tex

Local framerate#=60.0, animspeed#=10
Local timer:TTimer=CreateTimer(framerate)

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
While Not KeyHit(KEY_ESCAPE)
	
	PostFx.Time=Float((TimerTicks(timer) / framerate) * animspeed)
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
	Text 0,40,"WASD/Arrows: move camera, Space: PostFx.Active = "+PostFx.Active
	
	Flip
	GCCollect
	
Wend

End

Type TRenderPass

	Field Active:Byte=False
	Field Camera:TCamera, PostFxCam:TCamera
	Field PostFx:TPostFX=Null
	Field CameraTex:TTexture, NoiseTex:TTexture
	Field Light:TLight
	Field Sprite:TSprite	
	Field Shader:TShader
	Field Time#=0
	
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
		
		Local noisew%=TGlobal3D.width[0]/4, noiseh%=TGlobal3D.height[0]/4
		NoiseTex=CreateTexture(noisew,noiseh)
		Local noisemap:TPixmap=CreatePixmap(noisew,noiseh,PF_RGBA8888)
		For Local i%=0 To PixmapWidth(noisemap)-1
			For Local j%=0 To PixmapHeight(noisemap)-1
				Local rgb%=Rand(0,255)+(Rand(0,255) Shl 8)+(Rand(0,255) Shl 16)
				WritePixel noisemap,i,j,rgb|$ff000000
			Next
		Next
		BufferToTex NoiseTex,PixmapPixelPtr(noisemap,0,0)
		
		Shader=LoadShader("","../glsl/shimmer.vert.glsl", "../glsl/shimmer.frag.glsl")
		SetInteger(Shader,"currentTexture",0)
		SetInteger(Shader,"distortionMapTexture",1)
		SetFloat(Shader,"distortionFactor",0.005)' Factor used to control severity of the effect
		SetFloat(Shader,"riseFactor",0.002) ' Factor used to control how fast air rises
		UseFloat(Shader,"time",Time) ' Time used to scroll the distortion map
		
		PostFx=CreatePostFX(Camera,1)
		HideEntity Camera ' note: this boosts framerate as it prevents extra camera render
		
		PositionEntity Camera,0,7,0 ' move camera
		MoveEntity Camera,0,0,-25
		
		Local pass_no%=0, numColBufs%=2, depth%=0
		Local source_pass%=0, index%=1, slot%=0, frame%=0, value%=1
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
		PostFXTexture PostFx,pass_no,NoiseTex,1,frame
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
		
		Light=CreateLight()
		TurnEntity Light,45,45,0
		
		CameraTex=CreateTexture(TGlobal3D.width[0],TGlobal3D.height[0],1+256)
		ScaleTexture CameraTex,1.0,-1.0
		PositionTexture CameraTex,0.0,-1.0
		
		Local noisew%=TGlobal3D.width[0]/4, noiseh%=TGlobal3D.height[0]/4
		NoiseTex=CreateTexture(noisew,noiseh)
		Local noisemap:TPixmap=CreatePixmap(noisew,noiseh,PF_RGBA8888)
		For Local i%=0 To PixmapWidth(noisemap)-1
			For Local j%=0 To PixmapHeight(noisemap)-1
				Local rgb%=Rand(0,255)+(Rand(0,255) Shl 8)+(Rand(0,255) Shl 16)
				WritePixel noisemap,i,j,rgb|$ff000000
			Next
		Next
		BufferToTex NoiseTex,PixmapPixelPtr(noisemap,0,0)
		
		' in GL 2.0 render textures need attached before other textures (EntityTexture)
		CameraToTex CameraTex,Camera
		
		TGlobal3D.CheckFramebufferStatus(GL_FRAMEBUFFER_EXT) ' check for framebuffer errors
		
		Sprite:TSprite=CreateSprite()
		EntityOrder Sprite,-1
		ScaleSprite Sprite,1.0,Float( TGlobal3D.height[0] ) / TGlobal3D.width[0] ' 0.75
		MoveEntity Sprite,0,0,1.0 
		EntityParent Sprite,Camera
		
		PositionEntity Camera,0,7,0 ' move camera now sprite is parented to it
		MoveEntity Camera,0,0,-25
		
		Shader=LoadShader("","../glsl/shimmer.vert.glsl", "../glsl/shimmer.frag.glsl")
		ShaderTexture(Shader,CameraTex,"currentTexture",0) ' Our render texture
		ShaderTexture(Shader,NoiseTex,"distortionMapTexture",1) ' Our distortion map texture
		SetFloat(Shader,"distortionFactor",0.005)' Factor used to control severity of the effect
		SetFloat(Shader,"riseFactor",0.002) ' Factor used to control how fast air rises
		UseFloat(Shader,"time",Time) ' Time used to scroll the distortion map
		ShadeEntity(Sprite,Shader)
		
	End Method
	
	Method PollInput()
	
		If PostFx
			PollInputPostFx()
		Else
			PollInputSprite()
		EndIf
		
		' control camera
		MoveEntity Camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
		TurnEntity Camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
		
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
