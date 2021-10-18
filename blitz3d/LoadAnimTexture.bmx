' LoadAnimTexture.bmx

Strict

Framework Openb3d.B3dglgraphics

'Incbin "../media/boomstrip_dxt5.dds"

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

ClearTextureFilters ' remove default 1+8 flags to load non-mipmapped textures
TextureFilter "",1 ' always have at least one filter loaded or can randomly crash in GL 2.0

Local cube:TMesh=CreateCube()
PositionEntity cube,-2,0,5

Local cube2:TMesh=CreateCube()
PositionEntity cube2,2,0,5

'UseLibraryTextures 1

Local tex_flags%=1+16+32
tex_flags:+8 ' test mipmaps - boomstrip_dxt5_nomip.dds has no mipmaps

Local tex:TTexture=LoadAnimTexture("../media/boomstrip.bmp",tex_flags,64,64,0,39)
EntityTexture cube2,tex

' Load anim texture
Local oldtime%=MilliSecs()
Local anim_tex:TTexture=LoadAnimTexture("../media/boomstrip_dxt5.dds",tex_flags,64,64,0,39)

Local img_flags%=FILTEREDIMAGE ' warning: mipmapped images don't load correctly in GL 2.0 but non-mipmapped works
'img_flags=FILTEREDIMAGE|MIPMAPPEDIMAGE ' test mipmaps - boomstrip_dxt5_nomip.dds has no mipmaps

Local frame%,frame2%,frame3%
Local pitch#,yaw#,roll#

Local dds_img1:TImage=LoadAnimImageDDS("../media/boomstrip_dxt1.dds",64,64,0,39,img_flags)
Local dds_img3:TImage=LoadAnimImageDDS("../media/boomstrip_dxt3.dds",64,64,0,39,img_flags)
Local dds_img5:TImage=LoadAnimImageDDS("../media/boomstrip_dxt5_nomip.dds",64,64,0,39,img_flags)
Local dds_img_bgra:TImage=LoadAnimImageDDS("../media/boomstrip_bgra.dds",64,64,0,39,img_flags) ' bgra is preferred to rgba

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
	SetBlend ALPHABLEND
	DrawImage dds_img1,200,100,frame3
	DrawImage dds_img3,300,100,frame3
	DrawImage dds_img5,400,100,frame3
	DrawImage dds_img_bgra,500,100,frame3
	
	SetBlend SOLIDBLEND
	Text 0,20,"Arrows: turn cubes, anim texture frame="+frame
	EndMax2D()
		
	Flip
Wend
End
