' constraints.bmx
' yellow cube has halfway constraint points, grey cube doesn't (shows the subtle improvement in collision accuracy)

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
Local cube:TMesh=CreateCube()
EntityColor cube,255,255,0 ' yellow

Local piv:TPivot[20+1]
For Local i:Int=1 To 20
	piv[i]=CreatePivot()
	EntityType piv[i],1
	EntityRadius piv[i],0.01
Next

PositionEntity piv[1],-1,-1,-1
PositionEntity piv[2], 1,-1,-1
PositionEntity piv[3],-1, 1,-1
PositionEntity piv[4], 1, 1,-1
PositionEntity piv[5],-1,-1, 1
PositionEntity piv[6], 1,-1, 1
PositionEntity piv[7],-1, 1, 1
PositionEntity piv[8], 1, 1, 1

PositionEntity piv[9],-1,-1, 0 ' halfway points
PositionEntity piv[10], 0,-1, 1
PositionEntity piv[11], 0,-1, 1
PositionEntity piv[12], 1,-1, 0
PositionEntity piv[13],-1, 1, 0
PositionEntity piv[14], 0, 1, 1
PositionEntity piv[15], 0, 1, 1
PositionEntity piv[16], 1, 1, 0
PositionEntity piv[17],-1, 0,-1
PositionEntity piv[18], 1, 0, 1
PositionEntity piv[19],-1, 0, 1
PositionEntity piv[20], 1, 0,-1

For Local i:Int=1 To 8
	ActVector piv[i],0,-0.01,0
	ActNewtonian piv[i],0.9
	For Local i2:Int=i To 8
		If i=i2 Then Continue
		CreateConstraint piv[i],piv[i2], EntityDistance(piv[i],piv[i2])
	Next
Next

For Local i:Int=9 To 20
	ActVector piv[i],0,-0.01,0
	ActNewtonian piv[i],0.9
	For Local i2:Int=1 To 20
		If i=i2 Then Continue
		CreateConstraint piv[i],piv[i2], EntityDistance(piv[i],piv[i2])
	Next
Next

CreateRigidBody cube,piv[1],piv[2],piv[3],piv[5]
FitMesh cube,0,0,0,1,1,1

Local cube2:TMesh=CreateCube()
EntityColor cube2,128,128,128 ' grey

Local piv2:TPivot[8+1]
For Local i:Int=1 To 8
	piv2[i]=CreatePivot()
	EntityType piv2[i],1
	EntityRadius piv2[i],0.01
Next

PositionEntity piv2[1], 2,-1,-1
PositionEntity piv2[2], 4,-1,-1
PositionEntity piv2[3], 2, 1,-1
PositionEntity piv2[4], 4, 1,-1
PositionEntity piv2[5], 2,-1, 1
PositionEntity piv2[6], 4,-1, 1
PositionEntity piv2[7], 2, 1, 1
PositionEntity piv2[8], 4, 1, 1

For Local i:Int=1 To 8
	ActVector piv2[i],0,-0.01,0
	ActNewtonian piv2[i],0.9
	For Local i2:Int=i+1 To 8
		CreateConstraint piv2[i],piv2[i2], EntityDistance(piv2[i],piv2[i2])
	Next
Next

CreateRigidBody cube2,piv2[1],piv2[2],piv2[3],piv2[5]
FitMesh cube2,0,0,0,1,1,1

UpdateWorld
RenderWorld

'EntityType cube,-2
'EntityType cube2,-2

Local plane:TMesh=CreatePlane()
'ScaleEntity plane, 100,0.1,100
EntityType plane,-2
MoveEntity plane,0,-4,15
EntityColor plane,255,0,0

Local light:TLight=CreateLight()
PositionEntity light,5,5,5
PointEntity light,cube
MoveEntity camera,0,2,-15
PointEntity camera,cube

Local s:TMesh=CreateCube()
PositionEntity s,2,-3,0
ScaleEntity s,2,1,2
EntityType s,-2
'TurnEntity plane,0,0,10

Collisions 1,2,1,3

While Not KeyDown( KEY_ESCAPE )

	If KeyDown( KEY_H )=True Then MoveEntity s,0,0,0.1
	If KeyDown( KEY_P )=True Then MoveEntity s,0,0,-0.1
	If KeyDown( KEY_M )=True Then MoveEntity s,0.1,0,0
	If KeyDown( KEY_K )=True Then MoveEntity s,-0.1,0,0
	
	UpdateWorld 1
	RenderWorld
	
	Flip
Wend
End