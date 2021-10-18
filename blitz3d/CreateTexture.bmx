' CreateTexture.bmx

Strict

Framework Openb3d.B3dglgraphics

Import Brl.FreetypeFont

Graphics3D DesktopWidth(),DesktopHeight()

Local camera:TCamera=CreateCamera()

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

Local cube:TMesh=CreateCube()
PositionEntity cube,0,0,5

' Create texture of size 256x256
Local tex:TTexture=CreateTexture(256,256)
	
BeginMax2D()

' Clear texture buffer with background white color
SetClsColor 255,255,255
Cls

' Draw text on texture
Local font:TImageFont=LoadImageFont("../media/arial.ttf",20)
SetImageFont font
SetColor 0,0,0
DrawText "This texture",0,0
DrawText "was created using",0,40
SetColor 0,0,255
DrawText "CreateTexture",0,80
SetColor 0,0,0
DrawText "and drawn to using",0,120
SetColor 0,0,255
DrawText "BackBufferToTex",0,160

EndMax2D()

BackBufferToTex tex,0,0 'tex,mipmap_no=0,frame=0,fastinvert=True(new parameter)

' to use BufferToTex
'Local pix:TPixmap=GrabPixmap(0,0,256,256)
'If PixmapFormat(pix)<>PF_RGBA8888 Then pix=ConvertPixmap(pix,PF_RGBA8888)
'BufferToTex(tex,PixmapPixelPtr(pix,0,0))

EntityTexture cube,tex


While Not KeyDown( KEY_ESCAPE )

	Local pitch#=0
	Local yaw#=0
	Local roll#=0

	If KeyDown( KEY_DOWN )=True Then pitch#=-1	
	If KeyDown( KEY_UP )=True Then pitch#=1
	If KeyDown( KEY_LEFT )=True Then yaw#=-1
	If KeyDown( KEY_RIGHT )=True Then yaw#=1
	If KeyDown( KEY_Z )=True Then roll#=-1
	If KeyDown( KEY_X )=True Then roll#=1

	TurnEntity cube,pitch#,yaw#,roll#
	
	RenderWorld
	Flip
Wend
End
