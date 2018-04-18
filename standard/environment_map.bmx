' environment_map.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Incbin "../media/cubemap_skybox.png"

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,10,-15

' create separate camera for updating cube map - this allows us to avoid any confusion
Local cube_cam:TCamera=CreateCamera()
HideEntity cube_cam

Local light:TLight=CreateLight(2)
RotateEntity light,45,45,0
PositionEntity light,0,20,0
LightRange light,10

Local env_map$="../media/cubemap_skybox.png"
Local pix:TPixmap=LoadPixmap(env_map)
Local frame_size%=PixmapHeight(pix)/3

' Creates a skybox from the same cube map image in sideways cross -|-- 3 by 4 layout
' uses LoadAnimTexture( file,flags,w,h,firstframe,framecount ) where firstframe=0..11 (so 9 is frame x=1, y=2)
Local skybox:TMesh=LoadCubicSkyBox( env_map,1+16+32,frame_size,frame_size )
ScaleMesh skybox,250,250,250
PositionEntity skybox,0,50,0
EntityFX skybox,1

' ground
Local ground:TMesh=LoadMesh("../media/grid.b3d")
ScaleEntity ground,10,1,10
PositionEntity ground,0,-10,0
EntityColor ground,168,133,55
Local ground_tex:TTexture=LoadTexture("../media/sand.bmp")
ScaleTexture ground_tex,0.1,0.1
EntityTexture ground,ground_tex

'SetTextureLoader 2 ' 1 for streams (default), 2 for library

' create texture with color + cubic environment map
Local tex:TTexture=LoadTexture(env_map,1+128)

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

Local blendmode%=0, alpha#=1.0, showground%=1

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%


While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	' alpha blending
	If KeyHit(KEY_B)
		blendmode=Not blendmode
		If blendmode=0 Then alpha=1.0 Else alpha=0.7
		EntityAlpha teapot,alpha
		EntityAlpha ufo,alpha
		EntityAlpha camel,alpha
		EntityAlpha sphere,alpha
		EntityAlpha cone,alpha
		EntityAlpha cylinder,alpha
		EntityAlpha oildrum,alpha
	EndIf
	
	If KeyHit(KEY_G)
		showground=Not showground
		If showground=0 Then HideEntity ground Else ShowEntity ground
	EndIf
	
	' turn pivot, causing child meshes to spin around it
	If KeyDown(KEY_J) TurnEntity pivot,0,2,0
	If KeyDown(KEY_L) TurnEntity pivot,0,-2,0
	
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps
	Text 0,40,"WASD/Arrows: Move camera, J/L: Turn meshes, B: blendmode = "+blendmode+", G: show ground="+showground

	Flip

Wend
End

' Creates a skybox from the same cube map image in sideways cross -|-- 3 by 4 layout
Function LoadCubicSkyBox:TMesh( file$,flags%,width%,height% )

	Local m:TMesh=CreateMesh()
	
	'front face
	Local t:TTexture=LoadAnimTexture( file$,flags,width,height,5,1 )
	Local b:TBrush=CreateBrush()
	BrushTexture b,t
	Local s:TSurface=CreateSurface( m,b )
	AddVertex s,+1,+1,+1,1,0
	AddVertex s,-1,+1,+1,0,0
	AddVertex s,-1,-1,+1,0,1
	AddVertex s,+1,-1,+1,1,1
	AddTriangle s,0,1,2
	AddTriangle s,0,2,3	
	FreeBrush b
	
	'Right face
	t=LoadAnimTexture( file$,flags,width,height,6,1 )
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
	t=LoadAnimTexture( file$,flags,width,height,7,1 )
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
	
	'left face
	t=LoadAnimTexture( file$,flags,width,height,4,1 )
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
	
	'top face
	t=LoadAnimTexture( file$,flags,width,height,1,1 )
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
	
	'bottom face
	t=LoadAnimTexture( file$,flags,width,height,9,1 )
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
