' anisotropic.bmx
' anisotropic compared to isotropic (standard filtering), to show how it sharpens detail at angles

Strict

Framework Openb3dmax.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()

Local light:TLight=CreateLight()

ClearTextureFilters
TextureFilter "crate",1

GlobalAnIsotropic 1.0 ' global texture anisotropic (default for all), TextureAnIsotropic overrides

Local cube:TMesh=CreateCubeUV(1,6)
ScaleEntity cube,0.5,0.02,6
PositionEntity cube,-0.6,-0.5,5
Local tex1:TTexture=LoadTexture("../media/crate.bmp",1+8+1024) ' must init anisotropic flag (1024)
TextureAnIsotropic tex1,8.0 ' texture anisotropic factor, usually from 2-16 (higher more detail)
EntityTexture cube,tex1

Local cube2:TMesh=CreateCubeUV(1,6)
ScaleEntity cube2,0.5,0.02,6
PositionEntity cube2,0.6,-0.5,5
Local tex2:TTexture=LoadTexture("../media/crate.bmp",1+8)
EntityTexture cube2,tex2,0,0

Local tflag%=0

While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	
	' turn planks
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
			TextureFlags cube.brush.tex[0],1'+1024
			TextureFlags cube2.brush.tex[0],1
		Else
			TextureFlags cube.brush.tex[0],1+8+1024
			TextureFlags cube2.brush.tex[0],1+8
		EndIf
	EndIf
	
	RenderWorld
	
	Text 0,20,"Arrows: move camera, Left/Right: turn planks, T: texture flags = "+tflag
	
	Flip
	
Wend
End

' create a textured cube - tcu/tcv: texture scaling (from Minib3d TMesh.bmx)
Function CreateCubeUV:TMesh( tcu#,tcv#,parent_ent:TEntity=Null )

	Local mesh:TMesh=CreateMesh(parent_ent)
	Local surf:TSurface=CreateSurface(mesh)
	
	AddVertex(surf,-1.0,-1.0,-1.0)
	AddVertex(surf,-1.0, 1.0,-1.0)
	AddVertex(surf, 1.0, 1.0,-1.0)
	AddVertex(surf, 1.0,-1.0,-1.0)
	
	AddVertex(surf,-1.0,-1.0, 1.0)
	AddVertex(surf,-1.0, 1.0, 1.0)
	AddVertex(surf, 1.0, 1.0, 1.0)
	AddVertex(surf, 1.0,-1.0, 1.0)
	
	AddVertex(surf,-1.0,-1.0, 1.0)
	AddVertex(surf,-1.0, 1.0, 1.0)
	AddVertex(surf, 1.0, 1.0, 1.0)
	AddVertex(surf, 1.0,-1.0, 1.0)
	
	AddVertex(surf,-1.0,-1.0,-1.0)
	AddVertex(surf,-1.0, 1.0,-1.0)
	AddVertex(surf, 1.0, 1.0,-1.0)
	AddVertex(surf, 1.0,-1.0,-1.0)

	AddVertex(surf,-1.0,-1.0, 1.0)
	AddVertex(surf,-1.0, 1.0, 1.0)
	AddVertex(surf, 1.0, 1.0, 1.0)
	AddVertex(surf, 1.0,-1.0, 1.0)
	
	AddVertex(surf,-1.0,-1.0,-1.0)
	AddVertex(surf,-1.0, 1.0,-1.0)
	AddVertex(surf, 1.0, 1.0,-1.0)
	AddVertex(surf, 1.0,-1.0,-1.0)

	VertexNormal(surf,0,0.0,0.0,-1.0)
	VertexNormal(surf,1,0.0,0.0,-1.0)
	VertexNormal(surf,2,0.0,0.0,-1.0)
	VertexNormal(surf,3,0.0,0.0,-1.0)
	
	VertexNormal(surf,4,0.0,0.0,1.0)
	VertexNormal(surf,5,0.0,0.0,1.0)
	VertexNormal(surf,6,0.0,0.0,1.0)
	VertexNormal(surf,7,0.0,0.0,1.0)
	
	VertexNormal(surf,8,0.0,-1.0,0.0)
	VertexNormal(surf,9,0.0,1.0,0.0)
	VertexNormal(surf,10,0.0,1.0,0.0)
	VertexNormal(surf,11,0.0,-1.0,0.0)
	
	VertexNormal(surf,12,0.0,-1.0,0.0)
	VertexNormal(surf,13,0.0,1.0,0.0)
	VertexNormal(surf,14,0.0,1.0,0.0)
	VertexNormal(surf,15,0.0,-1.0,0.0)
	
	VertexNormal(surf,16,-1.0,0.0,0.0)
	VertexNormal(surf,17,-1.0,0.0,0.0)
	VertexNormal(surf,18,1.0,0.0,0.0)
	VertexNormal(surf,19,1.0,0.0,0.0)
	
	VertexNormal(surf,20,-1.0,0.0,0.0)
	VertexNormal(surf,21,-1.0,0.0,0.0)
	VertexNormal(surf,22,1.0,0.0,0.0)
	VertexNormal(surf,23,1.0,0.0,0.0)

	VertexTexCoords(surf,0,0.0,tcv)
	VertexTexCoords(surf,1,0.0,0.0)
	VertexTexCoords(surf,2,tcu,0.0)
	VertexTexCoords(surf,3,tcu,tcv)
	
	VertexTexCoords(surf,4,tcu,tcv)
	VertexTexCoords(surf,5,tcu,0.0)
	VertexTexCoords(surf,6,0.0,0.0)
	VertexTexCoords(surf,7,0.0,tcv)
	
	VertexTexCoords(surf,8,0.0,tcv)
	VertexTexCoords(surf,9,0.0,0.0)
	VertexTexCoords(surf,10,tcu,0.0)
	VertexTexCoords(surf,11,tcu,tcv)
	
	VertexTexCoords(surf,12,0.0,0.0)
	VertexTexCoords(surf,13,0.0,tcv)
	VertexTexCoords(surf,14,tcu,tcv)
	VertexTexCoords(surf,15,tcu,0.0)
	
	VertexTexCoords(surf,16,0.0,tcv)
	VertexTexCoords(surf,17,0.0,0.0)
	VertexTexCoords(surf,18,tcu,0.0)
	VertexTexCoords(surf,19,tcu,tcv)
	
	VertexTexCoords(surf,20,tcu,tcv)
	VertexTexCoords(surf,21,tcu,0.0)
	VertexTexCoords(surf,22,0.0,0.0)
	VertexTexCoords(surf,23,0.0,tcv)
	
	AddTriangle(surf,0,1,2) ' front
	AddTriangle(surf,0,2,3)
	AddTriangle(surf,6,5,4) ' back
	AddTriangle(surf,7,6,4)
	AddTriangle(surf,6+8,5+8,1+8) ' top
	AddTriangle(surf,2+8,6+8,1+8)
	AddTriangle(surf,0+8,4+8,7+8) ' bottom
	AddTriangle(surf,0+8,7+8,3+8)
	AddTriangle(surf,6+16,2+16,3+16) ' right
	AddTriangle(surf,7+16,6+16,3+16)
	AddTriangle(surf,0+16,1+16,5+16) ' left
	AddTriangle(surf,0+16,5+16,4+16)
	
	Return mesh
	
EndFunction
