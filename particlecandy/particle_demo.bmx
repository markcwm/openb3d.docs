' particle_demo.bmx

Strict

Framework Openb3d.B3dglgraphics
Import Openb3dmax.Particlecandy

?Not bmxng
Import Brl.Random
?bmxng
Import Brl.RandomDefault ' since v0.121
?

'TParticleCandy.DEBUG = True

Include "particletypes.bmx"

Graphics3D DesktopWidth(), DesktopHeight(), 0, 2

Global cube:TMesh[100]

Global light:TLight = CreateLight()
Global camera:TCamera = CreateCamera()
CameraRange camera, .1, 1000
CameraClsColor camera, 64, 128, 255
PositionEntity camera, 0, 10, 0
RotateEntity camera, 0, -45, 0

For Local i% = 0 To 99
	cube[i] = CreateCube()
	PositionMesh cube[i], Rnd(100), 1, Rnd(100)
	EntityColor cube[i], Rnd(255), Rnd(255), Rnd(255)
Next

PositionEntity light, -500, -500, -500
PointEntity light, cube[0]
MoveMouse 400, 300

Local ground:TMesh = CreatePlane()
EntityColor ground, 0, 255, 0

Global particlecandy:TParticleCandy = New TParticleCandy.Create()
particlecandy.Init( camera, "particles.png", 3 )
particlecandy.setParticleUpdateCycle( 2 )
Global emitter1:TParticleCandyEmitter = CreateEmitter_Test( particlecandy )
Global emitter2:TParticleCandyEmitter = CreateEmitter_Rocks( particlecandy )
Global emitter3:TParticleCandyEmitter = CreateEmitter_Explosion1( particlecandy )
Global emitter4:TParticleCandyEmitter = CreateEmitter_Explosion2( particlecandy )

HideMouse

' fps code
Local old_ms% = MilliSecs()
Local renders%, fps%

While Not KeyDown(KEY_ESCAPE)

	UpdateWorld
	Local MSY% = MouseY() - 300
	Local MSX% = MouseX() - 400

	RotateEntity camera, EntityPitch(camera) + MSY/2, EntityYaw(camera) - MSX/2, 0
	If KeyDown(KEY_S) Then MoveEntity camera, 0, 0, -.1
	If KeyDown(KEY_W) Then MoveEntity camera, 0, 0, .1
	If KeyDown(KEY_A) Then MoveEntity camera, -.1, 0, 0
	If KeyDown(KEY_D) Then MoveEntity camera , .1 , 0, 0
   
	If KeyHit( KEY_SPACE )
		particlecandy.clearParticles()
	End If    

	If KeyHit( KEY_1 )
		particlecandy.clearParticles()
		PositionEntity emitter1.piv, Rnd(50), 2, Rnd(50)
		emitter1.start()
	End If

	If KeyHit( KEY_2 )
		If emitter1.isActive() Then particlecandy.clearParticles()
		PositionEntity emitter2.piv, Rnd(50), 2, Rnd(50)
		emitter2.start()
	End If

	If KeyHit( KEY_3 )
		PositionEntity emitter3.piv, Rnd(50), 2, Rnd(50)
		If emitter1.isActive() Then particlecandy.clearParticles()
		emitter3.start()
	End If

	If KeyHit( KEY_4 )
		PositionEntity( emitter4.piv, Rnd(50), 2, Rnd(50) )
		If emitter1.isActive() Then particlecandy.clearParticles()
		emitter4.start()
	End If

	MoveMouse 400, 300
	particlecandy.render()
	RenderWorld
	
	' calculate fps
	renders = renders + 1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms = MilliSecs()
		fps = renders
		renders = 0
	EndIf
	
	BeginMax2D()
	DrawText "FPS: " + fps + ", Memory: " + GCMemAlloced(), 0, 20
	DrawText "Press 1-4 for Particle Types, Mouse for Camera Movement, Space to Clear", 0, 40
	EndMax2D()
	
	Flip True

Wend

particlecandy.Free()

End
