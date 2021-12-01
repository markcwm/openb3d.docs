' tonemap.bmx
' postprocess effect - render framebuffer to texture for Uncharted 2-style tonemapping
' by RonTek

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

Local size:Int=256, vsize:Float=30, maxheight:Float=10
Local terrain:TTerrain=LoadTerrain("../media/heightmap_256.BMP") ' path case-sensitive on Linux
ScaleEntity terrain,1,(1*maxheight)/vsize,1 ' set height
terrain.UpdateNormals() ' correct lighting
PositionEntity terrain,-size/2,-10,size/2

' Texture terrain
Local grass_tex:TTexture=LoadTexture( "../media/terrain-1.jpg" )
EntityTexture terrain,grass_tex
ScaleTexture grass_tex,10,10

Local pivot:TPivot=CreatePivot()
PositionEntity pivot,0,0,0
Local anim_time:Float
Local anim_ent:TMesh=LoadAnimMesh("../media/zombie.b3d",pivot)
PositionEntity anim_ent,0,0,12
TurnEntity anim_ent,0,-90,0

Local cube:TMesh=LoadMesh("../media/wcrate1.3ds")
ScaleMesh cube,0.15,0.15,0.15
PositionEntity cube,0,0.5,0
Local cube_tex:TTexture=LoadTexture("../media/crate.bmp",1)
EntityTexture cube,cube_tex
TurnEntity cube,0,45,0

Local framerate#=60.0, animspeed#=10
Local timer:TTimer=CreateTimer(framerate)

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
While Not KeyHit(KEY_ESCAPE)
	
	PostFx.Time=Float((TimerTicks(timer) / framerate) * animspeed)
	PostFx.PollInput()
	
	If KeyDown(KEY_MINUS) Then anim_time#=anim_time#-0.1
	If KeyDown(KEY_EQUALS) Then anim_time#=anim_time#+0.1
	
	anim_time:+0.5
	If anim_time>20 Then anim_time=2
	SetAnimTime(anim_ent,anim_time)
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
	Text 0,40,"B/V: exposure bias = "+PostFx.Bias+", M/N: Max white = "+PostFx.Maxwhite
	Text 0,60,"WSAD/Arrows: move camera, Space: PostFx.Active = "+PostFx.Active
	Text 0,80,"anim_time="+anim_time
	
	Flip
	
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
	Field Bias#=1.0, Maxwhite#=1.0, Time#=0
	
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
		
		Shader=LoadShader("","../glsl/default.vert.glsl", "../glsl/tonemap.frag.glsl")
		SetInteger(Shader,"texture0",0)
		UseFloat(Shader,"ExposureBias", Bias)
		UseFloat(Shader,"MaxWhite", Maxwhite)
		UseFloat(Shader,"time",Time) ' Time used to scroll the distortion map
		
		PostFx=CreatePostFX(Camera,1)
		HideEntity Camera ' note: this boosts framerate as it prevents extra camera render
		
		PositionEntity Camera,0,7,0 ' move camera
		MoveEntity Camera,0,0,-25
		
		Local pass_no%=0, numColBufs%=1, depth%=0
		Local source_pass%=0, index%=1, slot%=0, frame%=0, value%=1
		AddRenderTarget PostFx,pass_no,numColBufs,depth
		PostFXBuffer PostFx,pass_no,source_pass,index,slot
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
		
		Shader=LoadShader("","../glsl/default.vert.glsl", "../glsl/tonemap.frag.glsl")
		ShaderTexture(Shader,CameraTex,"texture0",0) ' Our render texture
		UseFloat(Shader,"ExposureBias", Bias)
		UseFloat(Shader,"MaxWhite", Maxwhite)
		UseFloat(Shader,"time",Time) ' Time used to scroll the distortion map
		ShadeEntity(Sprite,Shader)
		
	End Method
	
	Method PollInput()
	
		If PostFx
			PollInputPostFx()
		Else
			PollInputSprite()
		EndIf
		
		If KeyHit(KEY_B) Then Bias:+0.1
		If KeyHit(KEY_V) Then Bias:-0.1
		
		If KeyHit(KEY_M) Then Maxwhite:+0.1
		If KeyHit(KEY_N) Then Maxwhite:-0.1
		
		' control camera
		If KeyDown(KEY_D)=True Then MoveEntity Camera,0.25,0,0
		If KeyDown(KEY_A)=True Then MoveEntity Camera,-0.25,0,0
		If KeyDown(KEY_S)=True Then MoveEntity Camera,0,0,-0.25
		If KeyDown(KEY_W)=True Then MoveEntity Camera,0,0,0.25
		If KeyDown(KEY_UP)=True Then TurnEntity Camera,-1,0,0
		If KeyDown(KEY_DOWN)=True Then TurnEntity Camera,1,0,0
		If KeyDown(KEY_LEFT)=True Then TurnEntity Camera,0,1,0
		If KeyDown(KEY_RIGHT)=True Then TurnEntity Camera,0,-1,0
		
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
