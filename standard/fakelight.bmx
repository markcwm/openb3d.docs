' fakelight.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight()

Local camera:TCamera=CreateCamera()
PositionEntity camera,0,0,-5

AmbientLight 0,0,0

Local cube:TMesh=CreateSphere( 32 )

Local tex:TTexture=LoadTexture( "../media/brick.bmp" )
EntityTexture cube,tex

Local range#=5
Local lx#,ly#,lz#,lr#,lg#,lb#
RestoreData light_pos_rgb

For Local k%=1 To 6
	ReadData lx,ly,lz,lr,lg,lb
	Local light:TLight=CreateLight(2,cube)
	LightRange light,range
	LightColor light,lr,lg,lb
	PositionEntity light,lx,ly,lz
	LightMesh cube,lr,lg,lb,range,lx,ly,lz
Next

Local fake%=0

While Not KeyHit(KEY_ESCAPE)

	TurnEntity cube,.1,.2,.3

	If KeyHit(KEY_ENTER)
		fake=fake+1
		If fake>3 Then fake=0
		EntityFX cube,fake
	EndIf

	UpdateWorld
	RenderWorld
	Text 0,0,"Fake FX:"+fake
	Flip
Wend
End

#light_pos_rgb
DefData -2,0,0,255,0,0
DefData +2,0,0,0,255,0
DefData 0,+2,0,255,255,0
DefData 0,-2,0,255,0,255
DefData 0,0,-2,0,255,255
DefData 0,0,+2,255,255,255
