' example_01.bmx
' random cubes and spheres falling to the ground

SuperStrict

Framework Openb3dmax.Newtonb3d
Import Brl.Random

Include "newton_helpers.bmx"

Graphics3D DesktopWidth(), DesktopHeight(), 0, 60

Local update:Int = 1

' Use to exaggerate impact of large bodies on small bodies/vice versa, mass is based on size in this demo...
Const MASS_MULTI:Float = 1000.0

' Add/remove this many at once...
Const ADD_REMOVE:Int = 100

SeedRnd MilliSecs()

Local world:TNWorld = CreateNewtonWorld()

Local cam:TCamera = CreateCamera()
CameraClsColor cam, 32, 64, 128
MoveEntity cam, 0.0, 0.0, -25.0

AmbientLight 255.0, 255.0, 255.0
Local sun:TLight = CreateLight()
LightRange sun, 2000.0
MoveEntity sun, -1000.0, 1000.0, -500.0

Local ground:TNewtonGround = CreateNewtonGround(world, 100.0, 1.0, 100.0)
EntityColor ground.mesh, 0, 64, 0

Const BODY_CUBE:Int		= 1
Const BODY_SPHERE:Int	= 2

Local shadows:Int = 0
Local body_type:Int = BODY_CUBE
Local bodies:TList = CreateList()

PointEntity sun, ground.mesh
ResetNewtonWorld world

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' Main loop
Repeat

	' Change body type
	If KeyHit(KEY_B)
		body_type = body_type + 1
		
		Select body_type
			Case BODY_CUBE, BODY_SPHERE
			Default
				body_type = BODY_CUBE
		End Select
	EndIf
	
	' Move camera
	If KeyDown(KEY_LEFT) Then TurnEntity cam, 0.0, 1.0, 0.0, True
	If KeyDown(KEY_RIGHT) Then TurnEntity cam, 0.0, -1.0, 0.0, True
	
	If KeyDown(KEY_UP) Then TurnEntity cam, 1.0, 0.0, 0.0
	If KeyDown(KEY_DOWN) Then TurnEntity cam, -1.0, 0.0, 0.0
	
	If KeyDown(KEY_A) Then MoveEntity cam, 0.0, 0.0, 0.1 + KeyDown(KEY_LSHIFT) * 0.5
	If KeyDown(KEY_Z) Then MoveEntity cam, 0.0, 0.0, -(0.1 + KeyDown(KEY_LSHIFT) * 0.5)
	
	' Toggle shadows
	If KeyHit(KEY_S)
		shadows = 1 - shadows
		
		For Local body:TNewtonBody = EachIn bodies
			body.ToggleShadow shadows
		Next
	EndIf
	
	' Add cubes or spheres
	If KeyHit(KEY_EQUALS) Or KeyHit(KEY_NUMADD)
		For Local loop:Int = 1 To ADD_REMOVE
		
			Local body:TNewtonBody
			
			Select body_type
			
				Case BODY_CUBE
					body = TNewtonBody(AddRandomCube(world, MASS_MULTI, shadows))
					
				Case BODY_SPHERE
					body = TNewtonBody(AddRandomSphere(world, MASS_MULTI, shadows))
					
				Default
					body = Null
					
			End Select
			
			If body Then ListAddLast bodies, body
			
		Next
		
		ResetNewtonWorld world
	EndIf
	
	' Remove cubes or spheres
	If KeyHit(KEY_MINUS) Or KeyHit(KEY_NUMSUBTRACT)
	
		If CountList(bodies)
		
			Select body_type
			
				Case BODY_CUBE
					Local count:Int = 0
					
					For Local body:TNewtonCube = EachIn bodies
					
						If count < ADD_REMOVE
							body.Remove
							ListRemove bodies, body
							count = count + 1
						Else
							ResetNewtonWorld world
							Exit
						EndIf
						
					Next
					
				Case BODY_SPHERE
					Local count:Int = 0
					
					For Local body:TNewtonSphere = EachIn bodies
					
						If count < ADD_REMOVE
							body.Remove
							ListRemove bodies, body
							count = count + 1
						Else
							ResetNewtonWorld world
							Exit
						EndIf
						
					Next
					
				Default
					RuntimeError "Unknown body type!"
					
			End Select
			
		EndIf
		
	EndIf
	
	UpdateNewtonWorld world, update
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	BeginMax2D()
	ShadowText "FPS: "+fps,20,20
	ShadowText "[CURSORS] to rotate; [A/Z] to move, [SHIFT] to move faster", 20, 40
	ShadowText "[S] to toggle shadows on/off (shadows are SLOW!)", 20, 60
	ShadowText "[+/-] to add/remove " + ADD_REMOVE + " of currently-selected body type", 20, 80
	ShadowText "[B] to change body type, currently: ~q" + BodyType(body_type) + "~q", 20, 100
	ShadowText "Bodies: " + CountList(bodies) + " - check selected body type if not reducing!", 20, 120
	EndMax2D()
	
	Flip
	
Until KeyHit(KEY_ESCAPE) Or AppTerminate()


Function BodyType:String(body_type:Int)

	Select body_type
	
		Case BODY_CUBE
			Return "Cube"
		Case BODY_SPHERE
			Return "Sphere"
		Default
			RuntimeError "Unknown body type!"
		
	End Select
	
End Function
