' pixellight2.bmx
' per pixel lighting with alpha maps

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
CameraClsColor camera,70,180,235

Local lighttype%=2 ' set lighttype 1 or 2
Local light:TLight=CreateLight(lighttype)
RotateEntity light,45,45,0
PositionEntity light,10,10,0
LightColor light,150,150,150
AmbientLight 250,250,250

Local treeb3d$="../media/lo_perpix.b3d" ' note: media not provided
Local leaves$="../media/qqqq.png"
Local bark$="../media/tmp27.jpg"

Local tree:TMesh=LoadAnimMesh(treeb3d$)
PositionEntity tree,0,-1,3
ScaleEntity tree,0.03,0.03,0.03
If lighttype=2 Then LightRange(light,EntityDistance(light,tree)*1.25)

Local tree2:TMesh=LoadAnimMesh(treeb3d$)
PositionEntity tree2,0,-1,3
HideEntity tree2
ScaleEntity tree2,0.03,0.03,0.03

Local plane:TMesh=CreateCube()
ScaleEntity plane,10,0.1,10
MoveEntity plane,0,-1.5,0
Local grass:TTexture=LoadTexture("../media/Moss.bmp")
EntityTexture plane,grass
ScaleTexture grass,0.25,0.25

'Local shadow:TShadowObject=CreateShadow(tree)

Local brush:TBrush=LoadBrush(bark$)
PaintSurface tree.GetSurface(1),brush ' trunk is first surface of root mesh

Local shader:TShader=LoadShader("","../glsl/alphamap.vert.glsl","../glsl/alphamap2.frag.glsl")
ShaderTexture(shader,LoadTexture(leaves$),"tex",0)

Local shader2:TShader=LoadShader("","../glsl/pixellight2.vert.glsl","../glsl/pixellight2.frag.glsl")
SetInteger(shader2,"lighttype",lighttype)
ShaderTexture(shader2,LoadTexture(leaves$),"tex",0)

Local rootsurf:TSurface=tree.GetSurface(1) ' trunk is first surface of root mesh
BrushFX rootsurf.brush,0 ' trunk - no alpha
Local childent:TEntity=GetChild(tree,1)
Local childsurf:TSurface=TMesh(childent).GetSurface(1) ' leaf is first surface of first child
BrushFX childsurf.brush,32 ' leaf
ShadeSurface(childsurf,shader2)

Local pixellight%=2

While Not KeyDown(KEY_ESCAPE)

	' enable pixel lighting, 0=none, 1=alphamap, 2=pixellight + alphamap
	If KeyHit(KEY_P)
		pixellight:+1 ; If pixellight>2 Then pixellight=0
		If pixellight=0
			HideEntity tree ; ShowEntity tree2
		ElseIf pixellight=1
			ShadeSurface(childsurf,shader)
			HideEntity tree2 ; ShowEntity tree
		ElseIf pixellight=2
			ShadeSurface(childsurf,shader2)
			HideEntity tree2 ; ShowEntity tree
		EndIf
	EndIf

	TurnEntity tree,0,0.5,-0.1
	TurnEntity tree2,0,0.5,-0.1
	
	'UpdateWorld
	RenderWorld
	
	Text 0,20,"lighttype = "+lighttype+", P: pixellight = "+pixellight
	
	Flip

Wend
End
