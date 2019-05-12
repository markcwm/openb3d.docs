' load_dds_2d.bmx

Strict

Framework Brl.glmax2d
Import Openb3dmax.ddsloader
Import Openb3dmax.stbimageloader

Local width%=800, height%=600, depth%=0, rate%=60
Local flags%=GRAPHICS_BACKBUFFER|GRAPHICS_ALPHABUFFER|GRAPHICS_DEPTHBUFFER|GRAPHICS_STENCILBUFFER|GRAPHICS_ACCUMBUFFER

SetGraphicsDriver( GLMax2DDriver(),flags ) ' mixed 2d/3d
Local gfx_obj:TGraphics=Graphics( width,height,depth,rate,flags ) ' gfx object
glewInit() ' required for ARB funcs

Local dds_img1:TImage=LoadImageDDS("../media/dxt1.dds")
Local dds_img3:TImage=LoadImageDDS("../media/dxt3.dds")
Local dds_img5:TImage=LoadImageDDS("../media/dxt5.dds")
Local dds_img_rgba:TImage=LoadImageDDS("../media/dds_rgba.dds")

Local dds_alpha:TImage=LoadImageDDS("../media/smoke_dxt5.dds")

Local dds_ani_img_bgra:TImage=LoadAnimImageDDS("../media/boomstrip_bgra.dds",64,64,0,39) ' bgra is preferred to rgba
Local dds_ani_img3:TImage=LoadAnimImageDDS("../media/boomstrip_dxt3.dds",64,64,0,39)
Local dds_ani_img1:TImage=LoadAnimImageDDS("../media/boomstrip_dxt1.dds",64,64,0,39)
Local dds_ani_img5:TImage=LoadAnimImageDDS("../media/boomstrip_dxt5.dds",64,64,0,39)

Local non_dds_alpha:TImage=LoadImage("../media/smoke.png") ' note: load compressed dds before non-dds to avoid crash in GL 2.0

Local frame%,frame2%,frame3%

' main loop
While Not KeyHit(KEY_ESCAPE)
	Cls
	
	frame=MilliSecs()/100 Mod 39
	frame2=MilliSecs()/75 Mod 39
	frame3=MilliSecs()/125 Mod 39
	
	SetScale 0.5,0.5
	SetBlend ALPHABLEND
	DrawImage dds_img1,100,50
	DrawImage dds_img3,300,50
	DrawImage dds_img5,100,250
	DrawImage dds_img_rgba,300,250
	
	SetScale 1,1
	DrawImage dds_alpha,500,100
	DrawImage non_dds_alpha,500,300
	
	SetScale 0.5,0.5
	DrawImage dds_ani_img1,100,450,frame3
	DrawImage dds_ani_img3,200,450,frame3
	DrawImage dds_ani_img5,300,450,frame3
	DrawImage dds_ani_img_bgra,400,450,frame3
	
	SetScale 1,1
	SetBlend SOLIDBLEND
	DrawText "WASD: move camera",0,20
	
	Flip	
Wend

End
