' particle.bmx
' particle emitter functions: rate, life, variance, speed, vector

Strict

Framework Openb3dmax.B3dglgraphics
Import Brl.Random

Graphics3D DesktopWidth(),DesktopHeight(),0,2

ClearTextureFilters
TextureFilter("", 1 + 2)
Local camera:TCamera=CreateCamera()
CameraClsColor camera,100,150,200
PositionEntity camera,0,7,-20

Local light:TLight=CreateLight()
TurnEntity light,45,45,0

Local pivot:TPivot=CreatePivot()
PositionEntity pivot,0,2,0

Local t_sphere:TMesh=CreateSphere(8)
EntityShininess t_sphere,0.2

Local lastsphere:TEntity
For Local tr%=0 To 359 Step 60
	Local sphere:TEntity=CopyMesh(t_sphere,pivot)
	EntityColor sphere,Rnd(255),Rnd(255),Rnd(255)
	TurnEntity sphere,0,tr,0
	MoveEntity sphere,0,2,10
	lastsphere=sphere
Next
FreeEntity t_sphere

Local ground:TMesh=CreateCube()
ScaleEntity ground,1000,1,1000
Local ground_tex:TTexture=LoadTexture("../media/sand.bmp")
ScaleTexture ground_tex,0.01,0.01 ' scale uvs
EntityTexture ground,ground_tex

Local cone:TMesh=CreateCone()
PositionEntity cone,0,3,0

Local sprite:TSprite=CreateSprite()
EntityColor sprite,250,250,150
ScaleSprite sprite,1.5,1.5
EntityAlpha sprite,0.1
Local noisetex:TTexture=LoadTexture("../media/smoke.png",1+2)
EntityTexture sprite,noisetex

SpriteRenderMode sprite,2 ' mode 3 (point sprites) seem to not work
SpriteViewMode sprite,1 ' face camera
'ParticleTrail sprite,20 ' used in mode 3
'ParticleColor sprite,1.0,0,0,0.0 ' used in mode 3

Local pe:TParticleEmitter=CreateParticleEmitter(sprite)
MoveEntity pe,0,5,0
TurnEntity pe,-90,0,0

EmitterRate pe,1.0
EmitterParticleLife pe,100
EmitterVariance pe,0.07
EmitterParticleSpeed pe,0.1
EmitterVector pe,0.003,0.001,0

Local pe2:TParticleEmitter=TParticleEmitter( pe.CopyEntity() )
TurnEntity pe2,-90,0,0 ' rotate up

PositionEntity sprite,-15,5,15


While Not KeyHit(KEY_ESCAPE)
	
	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	If KeyDown(KEY_N) Then TurnEntity pe,0,1,0
	If KeyDown(KEY_M) Then TurnEntity pe,0,-1,0
	
	TurnEntity pivot,0,1,0
	
	PositionEntity pe2,EntityX(lastsphere,1),5,EntityZ(lastsphere,1)
	
	' update particles
	UpdateWorld
	RenderWorld
	BeginMax2D()
'	SetBlend ALPHABLEND
'	GLDrawText "??",0,20
	Text 0,20,"Arrows/WASD: move camera, N/M: rotate emitter"
	EndMax2D()
	
	Flip
Wend
End
