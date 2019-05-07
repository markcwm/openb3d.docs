' LoadAnimTexture.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Incbin "../media/boomstrip_dxt5.dds"

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

Local cube:TMesh=CreateCube()
PositionEntity cube,-2,0,5

Local cube2:TMesh=CreateCube()
PositionEntity cube2,2,0,5

TextureLoader "cpp"

Local tex:TTexture=LoadAnimTexture("../media/boomstrip.bmp",49,64,64,0,39 )
EntityTexture cube2,tex

TextureLoader "bmx"

' Load anim texture
Local oldtime%=MilliSecs()
Local anim_tex:TTexture=LoadAnimTexture( "incbin::../media/boomstrip_dxt5.dds",49,64,64,0,39 )

Local frame%,frame2%,frame3%
Local pitch#,yaw#,roll#

Local dds_img1:TImage=LoadAnimImageDDS("../media/boomstrip_dxt1.dds",64,64,0,39)
Local dds_img3:TImage=LoadAnimImageDDS("../media/boomstrip_dxt3.dds",64,64,0,39)
Local dds_img5:TImage=LoadAnimImageDDS("../media/boomstrip_dxt5.dds",64,64,0,39)
Local dds_img_bgra:TImage=LoadAnimImageDDS("../media/boomstrip_bgra.dds",64,64,0,39) ' bgra is preferred to rgba

' main loop
While Not KeyDown(KEY_ESCAPE)

	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)

	' Cycle through anim frame values. 100 represents Delay, 39 represents no. of  anim frames
	frame=MilliSecs()/100 Mod 39
	frame2=MilliSecs()/75 Mod 39
	frame3=MilliSecs()/125 Mod 39
	
	' Texture cube with anim texture frame
	EntityTexture cube,anim_tex,frame
	EntityTexture cube2,tex,frame2
	
	pitch#=0
	yaw#=0
	roll#=0
	
	If KeyDown(KEY_DOWN)=True Then pitch#=-1
	If KeyDown(KEY_UP)=True Then pitch#=1
	If KeyDown(KEY_LEFT)=True Then yaw#=-1
	If KeyDown(KEY_RIGHT)=True Then yaw#=1
	If KeyDown(KEY_X)=True Then roll#=-1
	If KeyDown(KEY_Z)=True Then roll#=1
	
	TurnEntity cube,pitch#,yaw#,roll#
	TurnEntity cube2,pitch#,-yaw#,roll#
	
	RenderWorld
	
	BeginMax2D()
	DrawImage dds_img1,200,100,frame3
	DrawImage dds_img3,300,100,frame3
	DrawImage dds_img5,400,100,frame3
	DrawImage dds_img_bgra,500,100,frame3
	Text 0,20,"Arrows: turn cubes, anim texture frame="+frame
	EndMax2D()
		
	Flip
Wend
End
