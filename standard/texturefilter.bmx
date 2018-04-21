' texturefilter.bmx

Strict

Framework Openb3dmax.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()

Local light:TLight=CreateLight()

ClearTextureFilters
TextureFilter "crate",1

Local cube:TMesh=CreateCube()
PositionEntity cube,-1.5,0,3
Local tex1:TTexture=LoadTexture("../media/crate.bmp")
EntityTexture cube,tex1

'MeshLoader "cpp"

Local cube2:TMesh=LoadAnimMesh("../media/wcrate1.3ds")
Local surf:TSurface=GetSurface(TMesh(GetChild(cube2,1)),1) ' first surface of first child
ScaleEntity cube2,0.06,0.06,0.06
RotateEntity cube2,0,180,0
PositionEntity cube2,1.5,-1.2,4
'Local tex2:TTexture=LoadTexture("../media/WCRATE.JPG")
'EntityTexture cube2,tex2,0,0

Local cone:TMesh=CreateCone()
PositionEntity cone,0,0,10
ScaleEntity cone,4,4,4

Local plane:TMesh=CreateCube()
ScaleEntity plane,10,0.1,10
MoveEntity plane,0,-1.5,0

Local tflag%=0

While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	
	' turn cubes
	If KeyDown(KEY_LEFT)
		TurnEntity cube,0,-0.5,0.1
		TurnEntity cube2,0,0.5,-0.1
	EndIf
	If KeyDown(KEY_RIGHT)
		TurnEntity cube,0,0.5,-0.1
		TurnEntity cube2,0,-0.5,0.1
	EndIf
	
	' texture filter is nearest (sharp) or linear/mipmap (smooth)
	If KeyHit(KEY_T)
		tflag=Not tflag
		If tflag
			TextureFlags cube.brush.tex[0],1
			TextureFlags surf.brush.tex[0],1
		Else
			TextureFlags cube.brush.tex[0],1+8
			TextureFlags surf.brush.tex[0],1+8
		EndIf
	EndIf
	
	RenderWorld
	
	Text 0,20,"Arrows: move camera, Left/Right: turn cubes, T: texture flags = "+tflag
	
	Flip
	
Wend
End
