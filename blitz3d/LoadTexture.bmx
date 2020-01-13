' LoadTexture.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight()

Local camera:TCamera=CreateCamera()

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

Local cube:TMesh=CreateCube()
PositionEntity cube,0,0,5

TextureLoader "cpp"

' Load texture
Local tex:TTexture=LoadTexture("../media/alpha_map.jpg")
TextureBlend tex,2
' Texture cube with texture
EntityTexture cube,tex

Local tex2:TTexture=LoadTexture("../media/alpha_map.jpg")
TextureBlend tex2,3
' Texture cube with texture
EntityTexture cube,tex

DebugLog tex.blend[0]+" "+tex.texture[0]+" "+tex.gltex[0]
DebugLog tex2.blend[0]+" "+tex2.texture[0]+" "+tex2.gltex[0]

While Not KeyDown( KEY_ESCAPE )

	Local pitch#=0
	Local yaw#=0
	Local roll#=0

	If KeyDown( KEY_DOWN )=True Then pitch#=-1	
	If KeyDown( KEY_UP )=True Then pitch#=1
	If KeyDown( KEY_LEFT )=True Then yaw#=-1
	If KeyDown( KEY_RIGHT )=True Then yaw#=1
	If KeyDown( KEY_X )=True Then roll#=-1
	If KeyDown( KEY_Z )=True Then roll#=1

	TurnEntity cube,pitch#,yaw#,roll#
	
	RenderWorld
	Flip

Wend

End
