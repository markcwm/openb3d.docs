' particle.bmx
' particle functions: rate, life, variance, speed, vector, color, scale, rotate

Strict

Framework Openb3d.B3dglgraphics

?Not bmxng
Import Brl.Random
?bmxng
Import Brl.RandomDefault ' since v0.121
?

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
ScaleSprite sprite,1.5,1.5
EntityAlpha sprite,0.91
Local noisetex:TTexture=LoadTexture("../media/smoke.png",1+2)
EntityTexture sprite,noisetex

SpriteRenderMode sprite,2 ' 2=batch sprites
SpriteViewMode sprite,1 ' face camera

Local startlife:Int=0
Local life:Int=75
Local pluslife:Int=25
Local startspeed:Float=0.03
Local endspeed:Float=-0.03 ' minus end speed to slow/reverse particles

Local startpitch:Float=-50
Local startyaw:Float=270
Local startroll:Float=0 ' roll has no effect so you don't need it
Local endpitch:Float=-50 ' set end angles to same as start, then reverse with minus speed
Local endyaw:Float=270
Local endroll:Float=0
Local stf:TVector=New TVector

Local pe:TParticleEmitter=CreateParticleEmitter(sprite)
MoveEntity pe,0,5,0

EmitterRate pe,1.01
EmitterVariance pe,0.025
EmitterParticleLife pe,startlife,life,pluslife
EmitterParticleSpeed pe,startspeed,endspeed

EmitterParticleAlpha pe,0.05,0.0,0.5,life/2 ' start and end alpha, 0..1
EmitterParticleScale pe,0.5,0.5,0.2,0.2,3.0,3.0,life/2 ' start and end scale xy, default is 1,1
EmitterParticleColor pe,250,250,200,250,250,250,250,200,150,life/2 ' start and end rgb, default 255,255,255
EmitterParticleRotate pe,0,1,8,life/2 ' minus values rotate clockwise

Local pe2:TParticleEmitter=TParticleEmitter( pe.CopyEntity() )

PositionEntity sprite,-15,5,15 ' base sprite

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%


While Not KeyHit(KEY_ESCAPE)
	
	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	If KeyDown(KEY_Y) Then startpitch:+1 ; endpitch:+1 ' keep end aligned with start angles (no end angles)
	If KeyDown(KEY_H) Then startpitch:-1 ; endpitch:-1
	If KeyDown(KEY_U) Then startyaw:+1 ; endyaw:+1
	If KeyDown(KEY_J) Then startyaw:-1 ; endyaw:-1
	If KeyDown(KEY_I) Then endpitch:+1 ' end angles allow you to bend (or arc) the flow of particles
	If KeyDown(KEY_K) Then endpitch:-1
	If KeyDown(KEY_O) Then endyaw:+1
	If KeyDown(KEY_L) Then endyaw:-1
	
	If KeyDown(KEY_EQUALS) Then startspeed:+0.0001
	If KeyDown(KEY_MINUS) Then startspeed:-0.0001
	If KeyDown(KEY_CLOSEBRACKET) Then endspeed:+0.0001
	If KeyDown(KEY_OPENBRACKET) Then endspeed:-0.0001
	
	If startpitch<-360 Or startpitch>360 Then startpitch=0
	If startyaw<-360 Or startyaw>360 Then startyaw=0
	If endpitch<-360 Or endpitch>360 Then endpitch=0
	If endyaw<-360 Or endyaw>360 Then endyaw=0
	
	RotateEntity pe,startpitch,startyaw,0
	TFormVector 0,0,0.1,pe,Null ' transform a vector along the +z axis (front) in global coords
	stf.x=TFormedX() ; stf.y=TFormedY() ; stf.z=TFormedZ() ' store start if using end angles
	
	RotateEntity pe,endpitch,endyaw,0
	TFormVector 0,0,0.1,pe,Null ' z doesn't have to be 0.1, it is so particle speed can be larger
	
	EmitterVector pe,stf.x,stf.y,stf.z,TFormedX(),TFormedY(),TFormedZ()
	EmitterParticleSpeed pe,startspeed,endspeed
		
	TurnEntity pivot,0,1,0
	PositionEntity pe2,EntityX(lastsphere,1),4.2,EntityZ(lastsphere,1)
	
	UpdateWorld ' update particles, actions, animations and collisions
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Arrows/WASD: move camera, YH/UJ: pitch/yaw, IK/OL: end pitch/yaw, -+/[]: start/end speed"
	Text 0,60,"startpitch="+startpitch+" startyaw="+startyaw+" endpitch="+endpitch+" endyaw="+endyaw
	Text 0,80,"Startspeed="+startspeed+" endspeed="+endspeed
	
	Flip
Wend
End
