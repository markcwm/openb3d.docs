' platform_collisions.bmx
' from Minib3d platform collisions by Warner
' by RonTek

Strict

Framework Openb3dMax.B3dglgraphics

?Not bmxng
Import Brl.Timer
Import Brl.Random
?bmxng
Import Brl.TimerDefault
Import Brl.RandomDefault ' since v0.121
?

Graphics3D 800, 600, 0, 2

Local light:TLight=CreateLight()

' everything is a child of this pivot
Local piv:TPivot = CreatePivot()

' create camera
Local cam:TCamera = CreateCamera(piv)
MoveEntity cam, 0, 5, -15
CameraClsColor cam, 0, 0, 255

' create cube (platform)
Local cube:TMesh = CreateCube(piv)
ScaleEntity cube, 4, 4, 4
PositionMesh cube, 0, -1.345, 0 ' <- start height
EntityType cube, 2
MoveEntity cube, 0, 0.4, 0
'MoveEntity cube, 0, 2, 0 ' <-rotation

' create ground
Local ground:TEntity = CreatePlane(1,piv)
EntityColor ground, 0, 255, 0
MoveEntity ground, 0, -1, 0
EntityType ground, 2

' create sphere (player)
Local sphere:TMesh = CreateSphere(8, piv)
EntityColor sphere, 255, 0, 0
PositionEntity sphere, -10, 1, 0
EntityType sphere, 1

' set collisions
Collisions 1, 2, 2, 3

Local hh#, p#
Local rotate_platform = False ' note: rotating player with the platform is not handled

Repeat

	' move sphere (player)
	If KeyDown(KEY_LEFT) MoveEntity sphere, -0.2, 0, 0 
	If KeyDown(KEY_RIGHT) MoveEntity sphere, 0.2, 0, 0
	If KeyDown(KEY_UP) MoveEntity sphere, 0, 0, 0.2 
	If KeyDown(KEY_DOWN) MoveEntity sphere, 0, 0, -0.2
	
	MoveEntity sphere, 0, -1, 0
	
	UpdateWorld 0 ' normal collisions
	
	If KeyDown(KEY_SPACE)
		p :+ 2
		hh = Sin(p) * 0.1
	EndIf
	
	EntityParent cube, Null ' remove parent
	If rotate_platform
		TurnEntity piv, 0, 1, 0 ' <-rotation
	EndIf
	
	' move everything, except cube (platform)
	If KeyDown(KEY_SPACE)
		TranslateEntity piv, 0, -hh, 0
	EndIf
	EntityParent cube, piv ' restore parent
	
	UpdateWorld 1 ' platform collisions
	RenderWorld
	
	Text 0, 20, "Arrows: move player, Spacebar: move platform"
	
	Flip
	
Until KeyHit(KEY_ESCAPE)

End

' alternative CreatePlane function
Function CreatePlane2:TEntity( parent:TEntity=Null )

	Local mesh:TMesh = CreateMesh(parent)
	Local surf:TSurface = CreateSurface(mesh)
	
	Local s# = 900.0
	AddVertex surf, -s, 0, s, -s, s
	AddVertex surf, s, 0, s, s, s
	AddVertex surf, s, 0, -s, s, -s
	AddVertex surf, -s, 0, -s, -s, -s
	AddTriangle surf, 0, 1, 2
	AddTriangle surf, 0, 2, 3
	VertexNormal surf, 0, 0, 1, 0
	VertexNormal surf, 1, 0, 1, 0
	VertexNormal surf, 2, 0, 1, 0
	VertexNormal surf, 3, 0, 1, 0
	
	Return mesh
	
End Function
