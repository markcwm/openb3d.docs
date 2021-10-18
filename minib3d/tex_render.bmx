' tex_render.bmx

Strict

Framework Openb3d.B3dglgraphics

?Not bmxng
Import Brl.Random
?bmxng
Import Brl.RandomDefault ' since v0.121
?

Graphics3D DesktopWidth(),DesktopHeight()

ClearTextureFilters

Local camera:TCamera=CreateCamera()
CameraClsColor camera,0,111,222

Local plan_cam:TCamera=CreateCamera()
TurnEntity plan_cam,90,0,0
PositionEntity plan_cam,0,20,0
CameraViewport plan_cam,0,0,128,128
CameraClsColor plan_cam,0,0,0

Local light:TLight=CreateLight()
TurnEntity light,45,45,0

Local pivot:TPivot=CreatePivot()
PositionEntity pivot,0,2,0

Local t_sphere:TMesh=CreateSphere( 8 )
EntityShininess t_sphere,0.2

For Local t%=0 To 359 Step 36
	Local sphere:TEntity=CopyMesh(t_sphere,pivot)
	EntityColor sphere,Rnd(256),Rnd(256),Rnd(256)
	TurnEntity sphere,0,t,0
	MoveEntity sphere,0,0,10
Next
FreeEntity t_sphere

Local texture:TTexture=CreateTexture(128,128)

Local cube:TMesh=CreateCube()
EntityTexture cube,texture
PositionEntity cube,0,7,0
ScaleEntity cube,3,3,3

Local d#=-20


While Not KeyHit(KEY_ESCAPE)

	If KeyDown(KEY_A) d=d+1
	If KeyDown(KEY_Z) d=d-1
	If KeyDown(KEY_LEFT) TurnEntity camera,0,-3,0
	If KeyDown(KEY_RIGHT) TurnEntity camera,0,+3,0
	
	PositionEntity camera,0,7,0
	MoveEntity camera,0,0,d
	
	TurnEntity cube,0.1,0.2,0.3
	TurnEntity pivot,0,1,0
	
	UpdateWorld
	
	HideEntity camera
	ShowEntity plan_cam
	RenderWorld
	
	BackBufferToTex texture
	
	ShowEntity camera
	'HideEntity plan_cam
	RenderWorld
	
	Flip
Wend
End
