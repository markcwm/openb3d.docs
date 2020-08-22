' load_3ds_stream.bmx
' note: there are two BMX 3DS loaders, to enable the alternative use MeshLoader "3ds2"

Strict

Framework Openb3dmax.B3dglgraphics
Import Koriolis.Zipstream

Incbin "../media/rallycar1.3ds"
Incbin "../media/RALLYCAR.JPG"

Graphics3D DesktopWidth(),DesktopHeight()

Local camera:TCamera=CreateCamera()
PositionEntity camera,0,35,-35
CameraClsColor camera,100,150,200

Local light:TLight=CreateLight()
RotateEntity light,45,45,0

Local mesh:TMesh, debug:String, oldtime:Int

MeshLoader "debug" ' mesh loader debug info
'MeshLoader "3ds2" ' alternative 3DS loader

Local loader:Int=0 ' set 0 to 2
Select loader
	Case 1 ' load incbin mesh
		oldtime=MilliSecs()
		Local file:String = "incbin::../media/rallycar1.3ds"
		mesh=LoadMesh(file)
		mesh.RotateMesh(90,0,0)
		mesh.ScaleMesh(0.2,0.2,0.2)
		
		debug="incbin time="+(MilliSecs()-oldtime)
		
	Case 2 ' load zip mesh
		oldtime=MilliSecs()
		Local zipfile:String = "../media/rallycar.zip"
		Local file:String = "zip::"+zipfile+"//rallycar1.3ds"
		mesh=LoadAnimMesh(file)
		mesh.RotateAnimMesh(90,0,0)
		mesh.ScaleAnimMesh(0.2,0.2,0.2)
		
		debug="zip time="+(MilliSecs()-oldtime)
		
	Default ' load non-stream mesh
		oldtime=MilliSecs()
		MeshLoader "trans" ' mesh transforms, default is "notrans"
		'mesh=LoadMesh("../media/rallycar1.3ds")
		mesh=LoadAnimMesh("../media/oildrum.3ds")
		mesh.RotateMesh(90,0,0)
		mesh.ScaleMesh(0.2,0.2,0.2)
		debug="3ds time="+(MilliSecs()-oldtime)

EndSelect

Local marker_ent:TMesh=CreateSphere(8)
EntityColor marker_ent,255,255,0
ScaleEntity marker_ent,0.25,0.25,0.25
EntityOrder marker_ent,-1

' used by fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

If MeshHeight(mesh)<100 Then PointEntity camera,mesh
Local count_children%=TEntity.CountAllChildren(mesh)

'Animate mesh,1,0.1,0,0


While Not KeyDown( KEY_ESCAPE )

	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	If KeyDown(KEY_I) And mesh Then TurnEntity mesh,0.5,0,0
	If KeyDown(KEY_K) And mesh Then TurnEntity mesh,-0.5,0,0
	If KeyDown(KEY_J) And mesh Then TurnEntity mesh,0,2.5,0
	If KeyDown(KEY_L) And mesh Then TurnEntity mesh,0,-2.5,0
	
	If KeyHit(KEY_F) And mesh
		FreeEntity mesh
		mesh=Null
	EndIf
	
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()+", Debug: "+debug
	Text 0,40,"WASD/Arrows: move camera, IJKL: turn mesh, F: free entity"
	If mesh
		Text 0,60,"mesh depth="+MeshDepth(mesh)+" height="+MeshHeight(mesh)
		Text 0,80,"mesh rot="+EntityPitch(mesh)+","+EntityYaw(mesh)+","+EntityRoll(mesh)
		Text 0,100,"Children: "+count_children
	EndIf
	
	Flip
	GCCollect
Wend

End
