' depthoffield.bmx
' postprocess effect - render framebuffer and depthbuffer to textures for depth of field
' configurable min/max blur range (by RonTek)

Strict

Framework Openb3dMax.B3dglgraphics
Import Brl.Random

Local width%=DesktopWidth(),height%=DesktopHeight()

Graphics3D width,height,0,2

SeedRnd MilliSecs()
ClearTextureFilters ' remove mipmap flag for postfx texture

Local PostFx:TRenderPass=New TRenderPass
PostFx.Init(1) ' init cameras, shaders, etc. (True for postfx renderer, False for screen sprite)
PostFx.Activate() ' note: depth buffering doesn't work in Gl 2.0

Local skymap:String="../media/envmap_cube.jpg"
Local pix:TPixmap=LoadPixmap(skymap)
Local framesize%=PixmapHeight(pix)/2 ' 3 * 2 cubemap layout

'Local skybox:TMesh=LoadCubicSkyBox( skymap,1+16+32,framesize,framesize,4,5,6,7,9,1 ) ' lf-x, fr+z, rt+x, bk-z, dn-y, up+y
Local skybox:TMesh=LoadCubicSkyBox( skymap,1+16+32,framesize,framesize,0,5,2,1,3,4 ) ' lf-x, fr+z, rt+x, bk-z, dn-y, up+y

ScaleMesh skybox,500,500,500
PositionEntity skybox,0,50,0
EntityFX skybox,1

Local sphere:TMesh
Local s_tex1:TTexture=LoadTexture("../media/tmp27.jpg",1+8)
Local s_tex2:TTexture=LoadTexture("../media/water.bmp",1+8)
Local s_tex3:TTexture=LoadTexture("../media/Moss.bmp",1+8)
For Local r:Int=0 To 6
	For Local t:Int=-2 To 2
		sphere=CreateSphere()
		PositionEntity sphere,(t*4),1,(t*4)+((r-2)*8)
		If r Mod 3=1 EntityTexture sphere,s_tex1
		If r Mod 3=2 EntityTexture sphere,s_tex2
		If r Mod 3=0 EntityTexture sphere,s_tex3
	Next
Next

Local cube:TMesh=LoadMesh("../media/wcrate1.3ds")
ScaleMesh cube,0.15,0.15,0.15
PositionEntity cube,0,8,40
Local cube_tex:TTexture=LoadTexture("../media/crate.bmp",1+8)
EntityTexture cube,cube_tex

Local ground:TMesh=CreatePlane(128)
Local ground_tex:TTexture=LoadTexture("../media/Envwall.bmp")
EntityTexture ground,ground_tex

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
While Not KeyDown(KEY_ESCAPE)

	PostFx.PollInput()
	
	PositionEntity skybox,EntityX(PostFx.Camera),EntityY(PostFx.Camera),EntityZ(PostFx.Camera)
	
	TurnEntity cube,0.1,0.2,0.3
	'TurnEntity pivot,0,1,0
	
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
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Space: PostFx.Active = "+PostFx.Active
	Text 0,60,"+/-: blursize = "+PostFx.Blursize +", [/]: maxblur = "+PostFx.Maxblur+", (/): minblur = "+PostFx.Minblur
	
	Flip
	GCCollect
	
Wend

Delay 100 ' try to avoid app hangs
PostFx.DeActivate()
PostFx.Render()

Delay 100

End

Type TRenderPass

	Field Active:Byte=False
	Field Camera:TCamera, PostFxCam:TCamera
	Field PostFx:TPostFX=Null
	Field CameraTex:TTexture, DepthTex:TTexture
	Field Light:TLight
	Field Sprite:TSprite, Sprite2:TSprite
	Field Shader:TShader
	Field Blursize#=0.002, Minblur#=10.0, Maxblur#=90.00
	
	Function Create:TRenderPass()
		Return New TRenderPass
	End Function
	
	Method Activate()
		Active=True
	End Method
	
	Method DeActivate()
		Active=False
	End Method
	
	' Set usepostfx% to True to use PostFx processor, False to use screen sprite method
	Method Init(usepostfx%=0)
	
		If usepostfx
			InitPostFx()
		Else
			InitSprite()
		EndIf
		
	End Method
	
	Method InitPostFx()
	
		Camera=CreateCamera()
		CameraRange Camera,0.5,1000.0 ' near must be closer than screen sprite to prevent clipping
		CameraClsColor Camera,150,200,250
		
		Light=CreateLight()
		TurnEntity Light,45,45,0
		
		Shader=LoadShader("","../glsl/depthoffield2.vert.glsl","../glsl/depthoffield2.frag.glsl")
		SetInteger(Shader,"colortex",0) ' 0 is render texture
		SetInteger(Shader,"depthtex",1) ' 1 is depth texture
		SetFloat(Shader,"rt_w", TGlobal3D.width[0])
		SetFloat(Shader,"rt_h", TGlobal3D.height[0])
		SetFloat(Shader,"bb_zNear", 0.5)
		SetFloat(Shader,"bb_zFar", 1000.0)
		UseFloat(Shader,"blursize",Blursize)
		UseFloat(Shader,"minblur",Minblur) ' set blur min/max range
		UseFloat(Shader,"maxblur",Maxblur)
		
		PostFx=CreatePostFX(Camera,1)
		HideEntity Camera ' note: this boosts framerate as it prevents extra camera render
		
		PositionEntity Camera,0,3,0 ' move camera now sprite is parented to it
		MoveEntity Camera,0,0,-25
		
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
		
		DepthTex=CreateTexture(TGlobal3D.width[0],TGlobal3D.height[0],1+256)
		ScaleTexture DepthTex,1.0,-1.0
		PositionTexture DepthTex,0.0,-1.0
		
		' in GL 2.0 render textures need attached before other textures (EntityTexture)
		CameraToTex CameraTex,Camera
		DepthBufferToTex DepthTex,camera
		
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
		
		PositionEntity Camera,0,3,0 ' move camera now sprite is parented to it
		MoveEntity Camera,0,0,-25
		
		Shader=LoadShader("","../glsl/depthoffield2.vert.glsl","../glsl/depthoffield2.frag.glsl")
		ShaderTexture(Shader,CameraTex,"colortex",0) ' 0 is render texture
		ShaderTexture(Shader,DepthTex,"depthtex",1) ' 1 is depth texture
		SetFloat(Shader,"rt_w", TGlobal3D.width[0])
		SetFloat(Shader,"rt_h", TGlobal3D.height[0])
		SetFloat(Shader,"bb_zNear", 0.5)
		SetFloat(Shader,"bb_zFar", 1000.0)
		UseFloat(Shader,"blursize",Blursize)
		UseFloat(Shader,"minblur",Minblur) ' set blur min/max range
		UseFloat(Shader,"maxblur",Maxblur)
		ShadeEntity(Sprite,Shader)
		
	End Method
	
	Method PollInput()
	
		If PostFx
			PollInputPostFx()
		Else
			PollInputSprite()
		EndIf
		
		If KeyDown(KEY_EQUALS) Then Blursize:+0.0001
		If KeyDown(KEY_MINUS) Then Blursize:-0.0001
		
		If KeyDown(KEY_CLOSEBRACKET) Then Maxblur:+1
		If KeyDown(KEY_OPENBRACKET) Then Maxblur:-1
		
		If KeyDown(KEY_0) Then Minblur:+1
		If KeyDown(KEY_9) Then Minblur:-1
		
		' control camera
		MoveEntity Camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
		TurnEntity Camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
		
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
			If Active>2 Then Active=0
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

' Create skybox from the same cubemap image
Function LoadCubicSkyBox:TMesh( file$, flags%, width%, height%, lf%, fr%, rt%, bk%, dn%, up% )

	Local t:TTexture, b:TBrush, s:TSurface
	Local m:TMesh=CreateMesh()

	'top face
	t=LoadAnimTexture( file$,flags,width,height,up,1 ) ' load single frame of same anim texture
	b=CreateBrush()
	BrushTexture b,t
	s=CreateSurface( m,b )
	AddVertex s,-1,+1,+1,0,1
	AddVertex s,+1,+1,+1,1,1
	AddVertex s,+1,+1,-1,1,0
	AddVertex s,-1,+1,-1,0,0
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3
	FreeBrush b

	'left face
	t=LoadAnimTexture( file$,flags,width,height,lf,1 )
	b=CreateBrush()
	BrushTexture b,t
	s=CreateSurface( m,b )
	AddVertex s,-1,+1,+1,1,0
	AddVertex s,-1,+1,-1,0,0
	AddVertex s,-1,-1,-1,0,1
	AddVertex s,-1,-1,+1,1,1
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3
	FreeBrush b

	'front face
	t=LoadAnimTexture( file$,flags,width,height,fr,1 )
	b=CreateBrush()
	BrushTexture b,t
	s=CreateSurface( m,b )
	AddVertex s,+1,+1,+1,1,0 ' ul
	AddVertex s,-1,+1,+1,0,0 ' ur
	AddVertex s,-1,-1,+1,0,1 ' dr
	AddVertex s,+1,-1,+1,1,1 ' dl
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3 
	FreeBrush b

	'right face
	t=LoadAnimTexture( file$,flags,width,height,rt,1 )
	b=CreateBrush()
	BrushTexture b,t
	s=CreateSurface( m,b )
	AddVertex s,+1,+1,-1,1,0
	AddVertex s,+1,+1,+1,0,0
	AddVertex s,+1,-1,+1,0,1
	AddVertex s,+1,-1,-1,1,1
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3
	FreeBrush b

	'back face
	t=LoadAnimTexture( file$,flags,width,height,bk,1 )
	b=CreateBrush()
	BrushTexture b,t
	s=CreateSurface( m,b )
	AddVertex s,-1,+1,-1,1,0
	AddVertex s,+1,+1,-1,0,0
	AddVertex s,+1,-1,-1,0,1
	AddVertex s,-1,-1,-1,1,1
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3
	FreeBrush b

	'down face
	t=LoadAnimTexture( file$,flags,width,height,dn,1 )
	b=CreateBrush()
	BrushTexture b,t
	s=CreateSurface( m,b )
	AddVertex s,-1,-1,-1,0,1 ' dl
	AddVertex s,+1,-1,-1,1,1 ' dr
	AddVertex s,+1,-1,+1,1,0 ' ur
	AddVertex s,-1,-1,+1,0,0 ' ul
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3
	FreeBrush b

	FlipMesh m
	Return m

End Function
