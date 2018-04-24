' textureblend.bmx
' using BrushBlend and TextureBlend

Strict

Framework Openb3dmax.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()

Local light:TLight=CreateLight()

Local cube:TMesh=CreateCube()
PositionEntity cube,-1.5,0,4

Local cube2:TMesh=CreateCube()
PositionEntity cube2,1.5,0,4

Local cone:TMesh=CreateCone()
PositionEntity cone,0,0,10
ScaleEntity cone,4,4,4

Local plane:TMesh=CreateCube()
ScaleEntity plane,10,0.1,10
MoveEntity plane,0,-1.5,0

Local tex0:TTexture=LoadTexture("../media/spark.png",1+2)
EntityTexture cube,tex0,0,0
Local tex1:TTexture=LoadTexture("../media/tex1.jpg",1)
EntityTexture cube,tex1,0,1
Local tex2:TTexture=LoadTexture("../media/tex2.jpg",1)
EntityTexture cube,tex2,0,2

Local brush:TBrush=CreateBrush()
Local surf:TSurface=GetSurface(cube,1)
'BrushFX(surf.brush,32)
'BrushBlend(surf.brush,1)

Local tex3:TTexture=LoadTexture("../media/alpha_map.png",1)
EntityTexture cube2,tex3
'EntityFX(cube2,32)

Local efx%=0,eblend%=2,etexenv%=2,multitexfactor#=0.5,ealpha#=1
BrushBlend surf.brush,eblend
TextureBlend tex1,etexenv
TextureBlend tex2,etexenv


While Not KeyDown(KEY_ESCAPE)

	' control camera
	TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	' turn cubes
	If KeyDown(KEY_LEFT)
		TurnEntity cube,0,-0.5,0.1
		TurnEntity cube2,0,0.5,-0.1
	EndIf
	If KeyDown(KEY_RIGHT)
		TurnEntity cube,0,0.5,-0.1
		TurnEntity cube2,0,-0.5,0.1
	EndIf
	
	' FX blending, alpha / nothing
	If KeyHit(KEY_F)
		efx=Not efx
		If efx
			BrushFX(surf.brush,32) ; EntityFX(cube2,32)
		Else
			BrushFX(surf.brush,0) ; EntityFX(cube2,0)
		EndIf
	EndIf
	
	' blend function, 1-3
	If KeyHit(KEY_B)
		eblend:+1
		If eblend>3 Then eblend=0
		If eblend=0 ' 0=alpha
			BrushBlend surf.brush,eblend
		ElseIf eblend=1 ' 1=alpha
			BrushBlend surf.brush,eblend
		ElseIf eblend=2 ' 2=multiply (default)
			BrushBlend surf.brush,eblend
		ElseIf eblend=3 ' 3=add
			BrushBlend surf.brush,eblend
		EndIf
	EndIf
	
	' Alpha blending
	If KeyHit(KEY_A)
		ealpha:-0.1
		If ealpha<0 Then ealpha=1
		EntityAlpha cube,ealpha
		EntityAlpha cube2,ealpha
	EndIf
	
	If KeyDown(KEY_LSHIFT) ' LShift + 0-8 key to blend texture 2 or 0-8 key to blend texture 1
	
		If KeyHit(KEY_0) ' 0: do not blend
			etexenv=0
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_1) ' 1: blend
			etexenv=1
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_2) ' 2: multiply (default)
			etexenv=2
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_3) ' 3: add
			etexenv=3
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_4) ' 4: dot3
			etexenv=4
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_5) ' 5: multiply2 (scale of 2 or 4)
			etexenv=5
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_6) ' 6: blend (invert)
			etexenv=6
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_7) ' 7: subtract
			etexenv=7
			TextureBlend tex2,etexenv
		EndIf
		If KeyHit(KEY_8) ' 8: interpolate
			etexenv=8
			multitexfactor:-0.1
			If multitexfactor<0.05 Then multitexfactor=1
			TextureBlend tex2,etexenv
			TextureMultitex tex2,multitexfactor
		EndIf
	
	Else
	
		If KeyHit(KEY_0) ' 0: do not blend
			etexenv=0
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_1) ' 1: blend
			etexenv=1
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_2) ' 2: multiply (default)
			etexenv=2
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_3) ' 3: add
			etexenv=3
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_4) ' 4: dot3
			etexenv=4
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_5) ' 5: multiply2 (scale of 2 or 4)
			etexenv=5
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_6) ' 6: blend (invert)
			etexenv=6
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_7) ' 7: subtract
			etexenv=7
			TextureBlend tex1,etexenv
		EndIf
		If KeyHit(KEY_8) ' 8: interpolate
			etexenv=8
			multitexfactor:-0.1
			If multitexfactor<0.05 Then multitexfactor=1
			TextureMultitex tex1,multitexfactor
			TextureBlend tex1,etexenv
		EndIf
		
	EndIf
	
	RenderWorld
	
	Text 0,20,"Arrows: turn camera, F: EntityFX blend = "+efx+", B: Brush blend = "+eblend+", A: EntityAlpha alpha="+ealpha
	Text 0,40,"LShift and/or 0-8 key: Texture blend="+etexenv+", 8 key: Interpolate multitexfactor="+multitexfactor
	Text 0,60,"Brush blend: 0=alpha, 1=alpha (default), 2=multiply, 3=add"
	Text 0,80,"Texture blend: 0=none, 1=blend, 2=multiply, 3=add, 4=dot3, 5=multiply2, 6=invert, 7=subtract, 8=interpolate"
	
	Flip
	
Wend
End
