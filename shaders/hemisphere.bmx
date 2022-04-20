' hemisphere.bmx
' per-vertex hemisphere lighting, from a Unity tutorial

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
CameraClsColor camera,70,180,235
CameraRange camera,0.1,100

Local mesh:TMesh=LoadMesh("../media/dwarf.b3d")
UpdateNormals mesh
TurnEntity mesh,0,180,0
'ScaleMesh mesh,20,20,20 ' bunny.obj
ScaleMesh mesh,0.10,0.10,0.10

Local pivot:TPivot=CreatePivot()

Local bulb:TMesh=CreateSphere(8,pivot)
ScaleMesh bulb,0.1,0.1,0.1
Local light:TLight=CreateLight(2,bulb)

Local vecpitch:Float=-90 ' -90 points up
Local vecyaw:Float=0
Local usetex:Int=0

Local upvec:TVector=New TVector
upvec.x=0
upvec.y=1.0
upvec.z=0
Local diffusecolor:TVector=New TVector
diffusecolor.x=1.0
diffusecolor.y=1.0
diffusecolor.z=1.0
Local uppercolor:TVector=New TVector
uppercolor.x=0.0
uppercolor.y=0.0
uppercolor.z=1.0
Local lowercolor:TVector=New TVector
lowercolor.x=0.0
lowercolor.y=1.0
lowercolor.z=0.0

Local shader:TShader=LoadShader("","../glsl/hemisphere.vert.glsl","../glsl/hemisphere.frag.glsl")
UseMatrix(shader,"_Object2World",0) ' 0=model matrix
UseMatrix(shader,"_World2Object",3) ' 3=modelview matrix

SetFloat4(shader,"_DiffuseColor",diffusecolor.x,diffusecolor.y,diffusecolor.z,1.0)
SetFloat4(shader,"_UpperHemisphereColor",uppercolor.x,uppercolor.y,uppercolor.z,1.0)
SetFloat4(shader,"_LowerHemisphereColor",lowercolor.x,lowercolor.y,lowercolor.z,1.0)
UseFloat3(shader,"_UpVector",upvec.x,upvec.y,upvec.z)
UseInteger(shader,"usetex",usetex)

ShaderTexture(shader,LoadTexture("../media/dwarf.jpg"),"tex0",0)
ShadeEntity(mesh,shader)

Local camz#=-6, bulby#=3, bulbyaw#=0, bulbz#=2
Local wiretoggle%=-1

' main loop
While Not KeyDown(KEY_ESCAPE)

	' wireframe
	If KeyHit(KEY_W) Then wiretoggle=-wiretoggle
	If wiretoggle=1 Then Wireframe True Else Wireframe False
	
	' texture with lighting
	If KeyHit(KEY_T)
		usetex:+1
		If usetex>2 Then usetex=0
	EndIf
	
	' move camera
	If KeyDown(KEY_O) Then camz:+0.1
	If KeyDown(KEY_P) Then camz:-0.1
	
	' move light
	If KeyDown(KEY_RIGHT) Then bulbyaw:+3
	If KeyDown(KEY_LEFT) Then bulbyaw:-3
	If KeyDown(KEY_UP) Then bulby:+0.1
	If KeyDown(KEY_DOWN) Then bulby:-0.1
	If KeyDown(KEY_Z) Then bulbz:+0.1
	If KeyDown(KEY_A) And bulbz>0 Then bulbz:-0.1
	
	PositionEntity camera,0,2,camz
	RotateEntity pivot,0,bulbyaw,0
	PositionEntity pivot,0,bulby,0
	PositionEntity bulb,0,0,bulbz
	
	PointEntity light,mesh
	TFormVector 0,0,0.1,light,Null ' transform a vector along the +z axis (front) in global coords
	upvec.x=TFormedX() ; upvec.y=TFormedY() ; upvec.z=TFormedZ()
	
	RenderWorld
	
	Text 0,20,"T: change texture blending = "+usetex+", O/P: move camera, Arrows & A/Z: move light"
	
	Flip

Wend
End
