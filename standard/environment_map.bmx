' environment_map.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Incbin "../media/cubemap_skybox.png"

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,5,-10

Local light:TLight=CreateLight(2)
RotateEntity light,45,45,0
PositionEntity light,0,20,0
LightRange light,10

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

Local skymap$="../media/cubemap_skybox.png"
Local pix:TPixmap=LoadPixmap(skymap)
Local framesize%=PixmapHeight(pix)/3

' Create a skybox from the same cube map image in 4 * 3 cross
Local skybox:TMesh=LoadCubicSkyBox( skymap,1+16+32,framesize,framesize,1,4,5,6,7,9 )
ScaleMesh skybox,250,250,250
PositionEntity skybox,0,50,0
EntityFX skybox,1

skymap="../media/envmap_cube.jpg"
pix=LoadPixmap(skymap)
framesize=PixmapHeight(pix)/2

Local skybox2:TMesh=LoadCubicSkyBox( skymap,1+16+32,framesize,framesize,4,0,5,2,1,3 ) ' bk, up, fr, rt, lf, dn
ScaleMesh skybox2,250,250,250
PositionEntity skybox2,0,50,0
EntityFX skybox2,1
HideEntity skybox2

' ground
Local ground:TMesh=CreateCylinder(16,True)
ScaleEntity ground,125,1,125
PositionEntity ground,0,-10,0
'Local ground_tex:TTexture=LoadTexture("../media/sand.bmp")
Local ground_tex:TTexture=LoadAnimTexture( skymap,1+8,framesize,framesize,3,1 )
'ScaleTexture ground_tex,0.1,0.1
EntityTexture ground,ground_tex

skymap="../media/cubemap_skybox.png"
pix=LoadPixmap(skymap)
framesize=PixmapHeight(pix)/3

CubeMapLoader "face",1,2,3,4,5,0 ' left, front, right, back, up, down
CubeMapLoader "frame",1,4,5,6,7,9

Local tex:TTexture=LoadAnimTexture(skymap,1+128,framesize,framesize,0,1)

skymap="../media/envmap_cube.jpg"
pix=LoadPixmap(skymap)
framesize=PixmapHeight(pix)/2

CubeMapLoader "face",0,5,2,1,3,4 ' left, back, right, down, up, front
CubeMapLoader "frame",0,1,2,3,4,5

Local tex2:TTexture=LoadAnimTexture(skymap,1+128,framesize,framesize,0,1)

Local cubemap_time%=Abs(MilliSecs()-old_ms)

Local pivot:TPivot=CreatePivot()

Local teapot:TMesh=LoadMesh("../media/teapot.b3d",pivot)
TurnEntity teapot,0,0,0
MoveEntity teapot,0,0,30
ScaleEntity teapot,5,5,5
EntityTexture teapot,tex

Local ufo:TMesh=LoadMesh("../media/green_ufo.b3d",pivot)
TurnEntity ufo,0,50,0
MoveEntity ufo,0,0,30
ScaleMesh ufo,5,5,5
EntityTexture ufo,tex

Local camel:TMesh=LoadMesh("../media/camel.b3d",pivot)
TurnEntity camel,0,100,0
MoveEntity camel,0,0,30
ScaleMesh camel,5,5,5
EntityTexture camel,tex

Local sphere:TMesh=CreateSphere(16,pivot)
TurnEntity sphere,0,150,0
MoveEntity sphere,0,0,30
ScaleMesh sphere,5,5,5
EntityTexture sphere,tex

Local cone:TMesh=CreateCone(16,True,pivot)
TurnEntity cone,0,200,0
MoveEntity cone,0,0,30
ScaleMesh cone,5,5,5
EntityTexture cone,tex

Local cylinder:TMesh=CreateCylinder(16,True,pivot)
TurnEntity cylinder,0,250,0
MoveEntity cylinder,0,0,30
ScaleMesh cylinder,5,5,5
EntityTexture cylinder,tex

Local oildrum:TMesh=LoadMesh("../media/oildrum.3ds",pivot)
TurnEntity oildrum,0,300,0
MoveEntity oildrum,0,-6,30
ScaleMesh oildrum,0.4,0.4,0.4
EntityTexture oildrum,tex,0,1
oildrum.UpdateVerticesNormals(GetSurface(oildrum,1))

PositionEntity pivot,0,0,40
PointEntity cam,pivot

Local blendmode%=0, alpha#=1.0, showground%=1, turn#=0, cubemode%=0, temptex:TTexture


While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	' alpha blending
	If KeyHit(KEY_B)
		blendmode=Not blendmode
		If blendmode=0 Then alpha=1.0 Else alpha=0.7
		EntityAlpha teapot,alpha
		'EntityAlpha ufo,alpha
		'EntityAlpha camel,alpha
		EntityAlpha sphere,alpha
		EntityAlpha cone,alpha
		EntityAlpha cylinder,alpha
		'EntityAlpha oildrum,alpha
	EndIf
	
	If KeyHit(KEY_G)
		showground=Not showground
		If showground=0 Then HideEntity ground Else ShowEntity ground
	EndIf
	
	If KeyHit(KEY_C)
		cubemode=Not cubemode
		If cubemode=0
			temptex=tex
			HideEntity skybox2
			ShowEntity skybox
		Else
			temptex=tex2
			HideEntity skybox
			ShowEntity skybox2
		EndIf
		EntityTexture teapot,temptex
		EntityTexture ufo,temptex
		EntityTexture camel,temptex
		EntityTexture sphere,temptex
		EntityTexture cone,temptex
		EntityTexture cylinder,temptex
		EntityTexture oildrum,temptex,0,1
	EndIf
	
	' turn pivot, causing child meshes to spin around it
	If KeyDown(KEY_J) Then TurnEntity pivot,0,1,0
	If KeyDown(KEY_L) Then TurnEntity pivot,0,-1,0
	
	If KeyDown(KEY_I) Then turn=1
	If KeyDown(KEY_K) Then turn=-1
	If Abs(turn)>0.1
		TurnEntity teapot,0,turn,turn/2
		TurnEntity ufo,0,turn,turn/2
		TurnEntity camel,0,turn,turn/2
		TurnEntity sphere,0,turn,turn/2
		TurnEntity cone,0,turn,turn/2
		TurnEntity cylinder,0,turn,turn/2
		TurnEntity oildrum,0,turn,turn/2
		turn=0
	EndIf
	
	' calculate fps
	renders=renders+1
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Cls
	RenderWorld
	
	BeginMax2DEx()
	SetColor 0,0,0
	GLDrawText "FPS: "+fps+" cubemap_time: "+cubemap_time,0,20
	GLDrawText "WASD/Arrows: Move camera, J/L: Turn pivot, I/K: Rotate meshes",0,40
	GLDrawText "B: blendmode = "+blendmode+", G: show ground="+showground,0,60
	EndMax2DEx()
	
	Flip
Wend
End
	
' Create a skybox from the same cube map image in 4 * 3 cross
Function LoadCubicSkyBox:TMesh( file$, flags%, width%, height%, up%, lf%, fr%, rt%, bk%, dn% )

	Local t:TTexture, b:TBrush, s:TSurface
	Local m:TMesh=CreateMesh()
	
	'top face
	t=LoadAnimTexture( file$,flags,width,height,up,1 )
	b=CreateBrush()
	BrushTexture b,t
	s=CreateSurface( m,b )
	AddVertex s,-1,+1,+1,0,1 ' tl
	AddVertex s,+1,+1,+1,1,1 ' tr
	AddVertex s,+1,+1,-1,1,0 ' br
	AddVertex s,-1,+1,-1,0,0 ' bl
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
	AddVertex s,+1,+1,+1,1,0 ' tl
	AddVertex s,-1,+1,+1,0,0 ' tl
	AddVertex s,-1,-1,+1,0,1 ' br
	AddVertex s,+1,-1,+1,1,1 ' bl
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
	AddVertex s,-1,-1,-1,0,1 ' bl
	AddVertex s,+1,-1,-1,1,1 ' br
	AddVertex s,+1,-1,+1,1,0 ' tr
	AddVertex s,-1,-1,+1,0,0 ' tl
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3
	FreeBrush b
	
	FlipMesh m
	Return m
	
End Function
