' CreatePlane.bmx
' infinite planes by way of a scrolling texture with sub-divisions for better lighting

Strict

Framework Openb3d.B3dglgraphics

Local width%=DesktopWidth(),height%=DesktopHeight(),depth%=0,Mode%=2

Graphics3D width,height,depth,Mode

Local cam_far# = 75 ' shrinking range far changes plane size, thus increasing sub-division detail
Global camera:TCamera=CreateCamera()
CameraRange camera,0.1,cam_far
MoveEntity camera,0,1.2,0

Local light:TLight=CreateLight(2)
MoveEntity light,0,cam_far,0
PointEntity light,camera

Local divisions% = 32 ' maximum sub-divisions is set at 64
Local plane:TMesh = CreatePlane(divisions)

Local texture:TTexture = LoadTexture("../media/test.png")
EntityTexture plane,texture
ScaleTexture texture,2,2 ' scale of the plane texture

Local cube:TMesh=CreateCube()
EntityTexture cube,texture ' note we can't reuse the plane texture, unlike in Blitz3D
PositionEntity cube,0,0,5

Local wiretoggle%=-1
Local surf:TSurface = GetSurface(plane,1)

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
While Not KeyHit(KEY_ESCAPE)

	' wireframe
	If KeyHit(KEY_W) Then wiretoggle=-wiretoggle
	If wiretoggle=1 Then Wireframe True Else Wireframe False
	
    If KeyDown(KEY_A) Then MoveEntity camera, -0.1,0,0
    If KeyDown(KEY_D) Then MoveEntity camera, 0.1,0,0
    If KeyDown(KEY_UP) Then MoveEntity camera, 0,0,0.1
    If KeyDown(KEY_DOWN) Then MoveEntity camera,0,0,-0.1
    If KeyDown(KEY_RIGHT) Then TurnEntity camera, 0,-1,0
    If KeyDown(KEY_LEFT) Then TurnEntity camera, 0,1,0
	
    'UpdateWorld
    RenderWorld ' planes are updated by RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Arrows: move camera, AD: strafe camera, W: wireframe"
	Text 0,0,"vertices="+CountVertices(surf)+" triangles="+CountTriangles(surf)
    Flip

Wend
End
