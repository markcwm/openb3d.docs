' LightMesh.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight()

Local camera:TCamera=CreateCamera()
MoveEntity camera,0,2,-10

Local ent:TMesh=CreateSphere(16)
'EntityAlpha ent,0.4
BrushAlpha ent.GetSurface(1).brush,0.8 ' first surface of root mesh

Local ent2:TMesh=CreateSphere(16)
MoveEntity ent2,0,1,5

Local light:TLight=CreateLight(1)
RotateEntity light,45,45,0

LightMesh ent,-255,-255,-255 ' reset vertex colors from 255,255,255 (Default) To 0,0,0
LightMesh ent,255,255,0,10,-20,20,-20 ' apply fake lighting

PointEntity camera,ent

Local fake%=2
EntityFX ent,fake

While Not KeyHit(KEY_ESCAPE)
	
	If KeyHit(KEY_ENTER)
		fake=fake+1
		If fake>3 Then fake=0
		EntityFX ent,fake
	EndIf

	UpdateWorld
	RenderWorld
	
	BeginMax2D()
	Text 0,0,"Fake FX:"+fake
	EndMax2D()
	
	Flip
Wend
End