' load_dds.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Incbin "../media/dxt1.dds"
Incbin "../media/dxt3.dds"
Incbin "../media/dxt5.dds"
Incbin "../media/dds_rgba.dds"

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
PositionEntity camera,0,1.2,-7
CameraClsColor camera,100,150,200

Local light:TLight=CreateLight()
TurnEntity light,45,45,0

Local dxt1:TMesh=CreateCube()
Local dxt3:TMesh=CreateCube()
Local dxt5:TMesh=CreateCube()
Local rgba:TMesh=CreateCube()

PositionEntity dxt1,-5,0,0
PositionEntity dxt3,5,0,0
PositionEntity dxt5,0,0,0
PositionEntity rgba,0,5,0

'TextureLoader "cpp"

Local file1$="incbin::../media/dxt1.dds"
Local file2$="incbin::../media/dxt3.dds"
Local file3$="incbin::../media/dxt5.dds"
Local file4$="incbin::../media/dds_rgba.dds"
If TGlobal.Texture_Loader=2 ' cpp loader - prevents crash
	file1="../media/dxt1.dds"
	file2="../media/dxt3.dds"
	file3="../media/dxt5.dds"
	file4="../media/dds_rgba.dds"
EndIf

Local dxt1_tex:TTexture=LoadTexture(file1)
Local dxt3_tex:TTexture=LoadTexture(file2)
Local dxt5_tex:TTexture=LoadTexture(file3)
Local rgba_tex:TTexture=LoadTexture(file4) ' uncompressed DDS

EntityTexture dxt1,dxt1_tex
EntityTexture dxt3,dxt3_tex
EntityTexture dxt5,dxt5_tex
EntityTexture rgba,rgba_tex

Local dds_img:TImage=LoadImageDDS("../media/dxt5.dds")

' main loop
While Not KeyHit(KEY_ESCAPE)

	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	
	TurnEntity dxt1,0,1,0
	TurnEntity dxt3,0,1,0
	TurnEntity dxt5,0,1,0
	TurnEntity rgba,0,1,0
	
	UpdateWorld
	RenderWorld
	
	BeginMax2D()
	DrawImage dds_img,100,100
	'DrawPixmap dxt1_tex.pixmap,200,200
	Text 0,20,"WASD: move camera"
	EndMax2D()
	
	Flip
	
Wend

FreeTexture dxt1_tex
FreeTexture dxt3_tex
FreeTexture dxt5_tex
FreeTexture rgba_tex

End
