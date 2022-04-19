' hemisphere.bmx
' per-vertex hemisphere lighting, from a Unity tutorial

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local camera:TCamera=CreateCamera()
CameraClsColor camera,70,180,235

Local light:TLight=CreateLight()

Local mesh:TMesh=LoadMesh("../media/dwarf.b3d")
TurnEntity mesh,0,180,0

Local pivotvec:TPivot=CreatePivot()
Local vecpitch:Float=0
Local vecyaw:Float=0
Local upvec:TVector=New TVector

Local usetex:Int=0
Local diffusecolor:TVector=New TVector
diffusecolor.x=1.0
diffusecolor.y=1.0
diffusecolor.z=1.0
Local uppercolor:TVector=New TVector
uppercolor.x=0.5
uppercolor.y=0.5
uppercolor.z=0.5
Local lowercolor:TVector=New TVector
lowercolor.x=0.0
lowercolor.y=0.1
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

Local camz#, tz#=55


While Not KeyDown(KEY_ESCAPE)

	' texture with lighting
	If KeyHit(KEY_T)
		usetex:+1
		If usetex>2 Then usetex=0
	EndIf
	
	' move mesh
	If KeyDown(KEY_UP) Then tz:+.1
	If KeyDown(KEY_DOWN) Then tz:-.1
	
	' move camera
	If KeyDown(KEY_W) Then camz:+.1
	If KeyDown(KEY_S) Then camz:-.1
	
	vecyaw:+1
	If vecyaw>360 Then vecyaw=0
	
	RotateEntity pivotvec,vecpitch,vecyaw,0
	TFormVector 0,0,0.1,pivotvec,Null ' transform a vector along the +z axis (front) in global coords
	upvec.x=TFormedX() ; upvec.y=TFormedY() ; upvec.z=TFormedZ()
	
	'TurnEntity mesh,0,0.5,-0.1
	
	PositionEntity mesh,0,0,tz
	PositionEntity camera,0,tz/2,camz
	
	RenderWorld
	
	Text 0,20,"T: change texture blending = "+usetex+", Up/Down: move mesh, W/S: move camera"
	Text 0,40,"Distance: "+Abs(EntityZ(mesh)-EntityZ(camera))+", light x = "+vecpitch+", light y = "+vecyaw
	
	Flip

Wend
End
