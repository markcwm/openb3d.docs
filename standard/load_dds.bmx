' load_dds.bmx

Strict

Framework Openb3dmax.B3dglgraphics

'Incbin "../media/dxt1.dds"

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
PositionEntity camera,0,1.2,-7
CameraClsColor camera,100,150,200

Local light:TLight=CreateLight()
TurnEntity light,45,45,0

ClearTextureFilters ' remove default 1+8 flags to load non-mipmapped textures
TextureFilter "",1 ' always have at least one filter loaded or can randomly crash in GL 2.0

Local dxt1:TMesh=CreateCube()
Local dxt3:TMesh=CreateCube()
Local dxt5:TMesh=CreateCube()
Local rgba:TMesh=CreateCube()

PositionEntity dxt1,-5,0,0
PositionEntity dxt3,5,0,0
PositionEntity dxt5,0,0,0
PositionEntity rgba,0,5,0

'UseLibraryTextures 1

Local tex_flags%=1
tex_flags:+8 ' test mipmaps - dxt5_nomip.dds has no mipmaps

Local dxt1_tex:TTexture=LoadTexture("../media/dxt1.dds",tex_flags)
Local dxt3_tex:TTexture=LoadTexture("../media/dxt3.dds",tex_flags)
Local dxt5_tex:TTexture=LoadTexture("../media/dxt5.dds",tex_flags)
Local rgba_tex:TTexture=LoadTexture("../media/dds_rgba.dds",tex_flags) ' uncompressed DDS

EntityTexture dxt1,dxt1_tex
EntityTexture dxt3,dxt3_tex
EntityTexture dxt5,dxt5_tex
EntityTexture rgba,rgba_tex

Local img_flags%=FILTEREDIMAGE ' warning: mipmapped images don't load correctly in GL 2.0 but non-mipmapped works
'img_flags=FILTEREDIMAGE|MIPMAPPEDIMAGE ' test mipmaps - dxt5_nomip.dds has no mipmaps

Local dds_img1:TImage=LoadImageDDS("../media/dxt1.dds",img_flags)
Local dds_img3:TImage=LoadImageDDS("../media/dxt3.dds",img_flags)
Local dds_img5:TImage=LoadImageDDS("../media/dxt5_nomip.dds",img_flags)
Local dds_img_rgba:TImage=LoadImageDDS("../media/dds_rgba.dds",img_flags)

'Local non_dds_alpha:TImage=LoadImage("../media/smoke.png",img_flags)
Local dds_alpha:TImage=LoadImageDDS("../media/smoke_dxt5.dds",img_flags)

Local dds_ani_img1:TImage=LoadAnimImageDDS("../media/boomstrip_dxt1.dds",64,64,0,39,img_flags)
Local dds_ani_img3:TImage=LoadAnimImageDDS("../media/boomstrip_dxt3.dds",64,64,0,39,img_flags)
Local dds_ani_img5:TImage=LoadAnimImageDDS("../media/boomstrip_dxt5_nomip.dds",64,64,0,39,img_flags)
Local dds_ani_img_bgra:TImage=LoadAnimImageDDS("../media/boomstrip_bgra.dds",64,64,0,39,img_flags) ' bgra is preferred to rgba

Local frame%,frame2%,frame3%

' main loop
While Not KeyHit(KEY_ESCAPE)

	frame=MilliSecs()/100 Mod 39
	frame2=MilliSecs()/75 Mod 39
	frame3=MilliSecs()/125 Mod 39
	
	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	
	TurnEntity dxt1,0,1,0
	TurnEntity dxt3,0,1,0
	TurnEntity dxt5,0,1,0
	TurnEntity rgba,0,1,0
	
	UpdateWorld
	RenderWorld
	
	BeginMax2D()
	SetScale 0.5,0.5
	SetBlend ALPHABLEND
	DrawImage dds_img1,100,50
	DrawImage dds_img3,300,50
	DrawImage dds_img5,100,250
	DrawImage dds_img_rgba,300,250
	
	SetScale 1,1
	DrawImage dds_alpha,100,500
	'DrawImage non_dds_alpha,400,500
	
	SetScale 0.5,0.5
	DrawImage dds_ani_img1,100,450,frame3
	DrawImage dds_ani_img3,200,450,frame3
	DrawImage dds_ani_img5,300,450,frame3
	DrawImage dds_ani_img_bgra,400,450,frame3
	
	SetBlend SOLIDBLEND
	Text 0,20,"WASD: move camera"
	EndMax2D()
	
	Flip
	Cls
	
Wend

FreeTexture dxt1_tex
FreeTexture dxt3_tex
FreeTexture dxt5_tex
FreeTexture rgba_tex

End
