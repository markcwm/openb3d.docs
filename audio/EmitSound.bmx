' EmitSound.bmx

SuperStrict

Framework Openb3d.B3dglgraphics

Local Drives:String[] = AudioDrivers()
For Local Drive:String = EachIn Drives
	Print Drive
Next

SetAudioDriver("OpenAL")

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
PositionEntity camera,0,1,-10

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

Local plane:TMesh=CreatePlane(16)
Local ground_tex:TTexture=LoadTexture("../media/castlest.jpg")
EntityTexture plane,ground_tex

Local cube:TMesh=CreateCube()
Local cube_tex:TTexture=LoadTexture("../media/b3dlogo.jpg")
EntityTexture cube,cube_tex
PositionEntity cube,0,1,0

Local microphone:TEntity=CreateListener(camera) ' Create listener, make it child of camera
Local sound:TSound=Load3DSound("../media/ufo.wav") ' Load 3D sound

While Not KeyDown(KEY_ESCAPE)

If KeyDown(KEY_RIGHT)=True Then TurnEntity camera,0,-1,0
If KeyDown(KEY_LEFT)=True Then TurnEntity camera,0,1,0
If KeyDown(KEY_DOWN)=True Then MoveEntity camera,0,0,-0.05
If KeyDown(KEY_UP)=True Then MoveEntity camera,0,0,0.05

' If left mouse button hit then emit sound from cube
If MouseHit(1) = True Then EmitSound(sound,cube)

RenderWorld

Text 0,0,"Use cursor keys to move about"
Text 0,20,"Press left mouse button to make a sound be emitted from the cube"

Flip

Wend

End
