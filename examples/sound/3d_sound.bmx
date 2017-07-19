' 3d_sound.bmx

SuperStrict

Framework Openb3d.B3dglgraphics
Import Openb3dmax.B3dsound
?Not Win32
Import Brl.FreeAudioAudio
?Win32
Import Brl.DirectSoundAudio
?
Import Brl.WavLoader
Import Brl.OggLoader

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Global Camera:TCamera = CreateCamera()
PositionEntity(camera, 0, 0, -20)

Global Light:TLight = CreateLight(1)
RotateEntity(Light, 90, 0, 0)

' Normal sound flags still apply, see Audio docs for more info
Global SampleSound:TSound = LoadSound("../media/sample.wav")

' This can be any kind of entity for the purposes of emitting sound
Global TheBox:TMesh = CreateCube()
EntityColor TheBox,50,100,200

' Initializes the 3D sound system. Sets camera as the listen point with sound heard up to 300 units away.
' To enable doppler effect, set the ExaggerateDopplerScale value. For example, Init3DSound(Camera, 300, 25).
' Doppler effect is relative to movement speed so if your game moves faster than 1 unit per cycle then a
' lower doppler exaggerate will be needed. A higher value will make the doppler effect more pronounced.
Init3DSound(Camera, 300)


While Not KeyHit(KEY_ESCAPE)

	' Move camera
	MoveEntity camera,0,0,KeyDown(KEY_UP)-KeyDown(KEY_DOWN)
	TurnEntity camera,0,KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	' Make TheBox play the loaded SampleSound
	If KeyHit(KEY_SPACE)
		Start3DSound(SampleSound, TheBox)
	EndIf
	
	UpdateWorld
	
	Update3DSounds() ' Update the positional information and sound channels for all playing 3D sounds
	
	RenderWorld
		
	Text 0,20,"Arrow keys: move and turn"
	Text 0,40,"Space: play sound from box, Memory: "+GCMemAlloced()
	
	Flip
	GCCollect
Wend
End
