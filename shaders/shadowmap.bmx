' shadowmap.bmx
' textured shadows, from OpenB3DPlus
' only works in 640x480 mode and not at all on Mac, there is also a rendering bug

Strict

Framework Openb3d.B3dglgraphics

Graphics3D 640,480,0,2

Local mapsize%=512 ' only works in 512x512

Local light:TLight=CreateLight()

Global CamLight:TCamera=CreateCamera(light)
CameraViewport(CamLight,0,0,mapsize,mapsize)
HideEntity(CamLight)

Local camera:TCamera=CreateCamera()
CameraClsColor camera,0,0,255

Local cube_tex:TTexture=LoadTexture("../media/07_DIFFUSE.jpg")

Local cube:TMesh=CreateCube()
EntityColor cube,255,0,0
MoveEntity cube,0,2,0

Local cone:TMesh=CreateCone()
EntityColor cone,0,255,0
MoveEntity cone,-3,2,0

Local cylinder:TMesh=CreateCylinder()
EntityColor cylinder,0,0,255
MoveEntity cylinder,3,2,0

Local plane:TMesh=CreatePlane(4)
MoveEntity plane,0,-1.5,0
'ScaleMesh plane, 10,0.1,10
EntityTexture plane, cube_tex

MoveEntity light,10,20,-3
PointEntity light,cube
MoveEntity camera,-2,1.5,-5

Global ShadowSampler:TTexture=CreateTexture(mapsize,mapsize,1+16+32,1)

Global ShadowMap:TShader=LoadShader("","../glsl/shadowmap.vert.glsl","../glsl/shadowmap.frag.glsl")
ShaderTexture(ShadowMap, cube_tex, "Diffuse", 0)
ShaderTexture(ShadowMap, ShadowSampler, "depthSampler", 1)

CreateShadowMap(ShadowMap, CamLight, ShadowSampler)

ShadeEntity plane, ShadowMap
ShadeEntity cube, ShadowMap
ShadeEntity cone, ShadowMap
ShadeEntity cylinder, ShadowMap

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

' main loop
While Not KeyHit(KEY_ESCAPE)

	If KeyDown( KEY_RIGHT )=True Then TurnEntity camera,0,-1,0
	If KeyDown( KEY_LEFT )=True Then TurnEntity camera,0,1,0
	If KeyDown( KEY_DOWN )=True Then MoveEntity camera,0,0,-0.25
	If KeyDown( KEY_UP )=True Then MoveEntity camera,0,0,0.25
	
	If KeyDown(KEY_W) Then TurnEntity cube,1,0,0,0 ; TurnEntity cone,1,0,0,0 ; TurnEntity cylinder,1,0,0,0
	If KeyDown(KEY_S) Then TurnEntity cube,-1,0,0,0 ; TurnEntity cone,-1,0,0,0 ; TurnEntity cylinder,-1,0,0,0
	If KeyDown(KEY_A) Then TurnEntity cube,0,-1,0,0 ; TurnEntity cone,0,-1,0,0 ; TurnEntity cylinder,0,-1,0,0
	If KeyDown(KEY_D) Then TurnEntity cube,0,1,0,0 ; TurnEntity cone,0,1,0,0 ; TurnEntity cylinder,0,1,0,0

	UpdateWorld 1
	UpdateShadows(ShadowSampler, CamLight)
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Arrows: move camera, WASD: turn cube, cone, cylinder"
	
	Flip
	
Wend

End

' functions
Function UpdateShadows(ShadowSampler:TTexture, CamLight:TCamera)

	glPolygonOffset (2.0, 1.0)
	glEnable(GL_POLYGON_OFFSET_FILL)
	DepthBufferToTex(ShadowSampler, CamLight)
	glDisable(GL_POLYGON_OFFSET_FILL)
	
End Function

Function CreateShadowMap(ShadowMap:TShader, CamLight:TCamera, ShadowSampler:TTexture)

	glBindTexture(GL_TEXTURE_2D,ShadowSampler.texture[0])
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_COMPARE_MODE, GL_COMPARE_R_TO_TEXTURE)
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_COMPARE_FUNC, GL_LESS)
	glTexParameteri(GL_TEXTURE_2D, GL_DEPTH_TEXTURE_MODE, GL_INTENSITY)
	
	SetInteger(ShadowMap, "Diffuse",0)
	SetInteger(ShadowMap, "depthSampler",1)
	
	UseEntity(ShadowMap, "lightingInvMatrix", CamLight, 1)
	UseMatrix(ShadowMap, "modelMat",0)

	'UseMatrix(ShadowMap, "projMatrix",2)
	'UseMatrix(ShadowMap, "biasMatrix",3)
	
	Local biasMatrix:Float[]=[0.5, 0.0, 0.0, 0.0,0.0, 0.5, 0.0, 0.0,0.0, 0.0, 0.5, 0.0,0.5, 0.5, 0.5, 1.0]
	Local prog%=GetShaderProgram(ShadowMap)
	
	glUseProgram(prog)
	
	glUniformMatrix4fv(glGetUniformLocation(prog,"biasMatrix"), 1, 0, Varptr biasMatrix[0])
	glUniformMatrix4fv(glGetUniformLocation(prog,"projMatrix"), 1, 0, CameraProjMatrix(CamLight))
	
	glUseProgram(0)
	
End Function
