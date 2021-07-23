' CreateTexture2.bmx
' per-pixel access for textures

Strict

Framework Openb3dmax.B3dglgraphics

?Not bmxng
Import Brl.Random
?bmxng
Import Brl.RandomDefault ' since v0.121
?

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
CameraClsColor camera,80,160,240

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

Local cube2:TMesh=CreateSphere()
PositionEntity cube2,0,2,5
Local cube:TMesh=CreateCube()
PositionEntity cube,0,0,3

Local size%=32
Local tex:TTexture=CreateTexture(size,size)

Local map:TPixmap=CreatePixmap(size,size,PF_RGBA8888)
For Local i%=0 To PixmapWidth(map)-1
	For Local j%=0 To PixmapHeight(map)-1
		Local rgb%=Rand(0,255)+(Rand(0,255) Shl 8)+(Rand(0,255) Shl 16)
		WritePixel map,i,j,rgb|$ff000000
	Next
Next

BufferToTex tex,PixmapPixelPtr(map,0,0)
EntityTexture cube,tex


While Not KeyDown(KEY_ESCAPE)

	TurnEntity cube,0.0,0.5,-0.1
	If KeyHit(KEY_A)
	HideEntity cube2
	EndIf
	
	RenderWorld
	Text 0,0,""+TrisRendered()
	Flip

Wend
End
