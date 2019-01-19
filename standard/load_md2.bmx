' load_md2.bmx
' mesh with single surface, vertex-interpolated animation

Strict

Framework Openb3dmax.B3dglgraphics

Local width%=DesktopWidth(),height%=DesktopHeight(),depth%=0,Mode%=2

Graphics3D width,height,depth,Mode

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,10,-60
CameraClsColor cam,100,150,200

Local light:TLight=CreateLight()

Local mesh:TMesh, debug:String, oldtime:Int

MeshLoader "debug" ' mesh loader debug info

'LoaderMatrix "md2", 1,0,0, 0,0,1, 0,-1,0 ' swap z/y and invert y

Local loader:Int=1 ' set 0 to 1
Select loader
	Case 1 ' load mesh
		oldtime=MilliSecs()
		mesh=LoadAnimMesh("../media/tris.md2")
		RotateEntity mesh,0,180,0
		
		Local tex:TTexture=LoadTexture("../media/skin4.jpg")
		EntityTexture mesh,tex
		
		debug="md2 time="+(MilliSecs()-oldtime)
		
	Default ' load library mesh
		TextureLoader "cpp"
		MeshLoader "cpp"
		
		oldtime=MilliSecs()
		mesh=LoadAnimMesh("../media/tris.md2")
		RotateEntity mesh,-90,180,0
		
		Local tex:TTexture=LoadTexture("../media/skin4.jpg")
		EntityTexture mesh,tex
		
		debug="lib time="+(MilliSecs()-oldtime)
EndSelect

Local marker_ent:TMesh=CreateSphere(8)
EntityColor marker_ent,255,255,0
ScaleEntity marker_ent,0.25,0.25,0.25
EntityOrder marker_ent,-1

Local anim_time#=0.0

' used by fps code
Local old_ms%=MilliSecs()
Local renders%=0, fps%=0

'Animate mesh,1,0.1,0,0


While Not KeyDown(KEY_ESCAPE)

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	' change anim time values
	If KeyDown(KEY_MINUS) Then anim_time=anim_time-0.1
	If KeyDown(KEY_EQUALS) Then anim_time=anim_time+0.1
	
	If mesh Then SetAnimTime(mesh,anim_time)
	
	If KeyHit(KEY_F) And mesh
		FreeEntity(mesh) 
		mesh=Null
	EndIf
	
	UpdateWorld
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()+", Debug: "+debug
	Text 0,40,"+/-: animate, F: free entity"
	Text 0,60,"Arrows: turn camera, WASD: move camera"
	
	Flip
	GCCollect
Wend

End
