' loadmesh_threads.bmx
' using CopyEntity in threads, tutorial credit to TomToad

Strict

Framework Openb3d.B3dglgraphics

Global Mutex:TMutex=CreateMutex() ' the mutex will be locked anytime a thread needs access

Graphics3D DesktopWidth(),DesktopHeight()

Local camera:TCamera=CreateCamera()
PositionEntity camera,0,10,-15
CameraClsColor camera,100,150,200
TurnEntity camera,50,0,0

Local light:TLight=CreateLight(2)
PositionEntity light,15,10,10

Local plane:TMesh=CreateCube()
ScaleEntity plane,12.5,0.1,12.5
MoveEntity plane, 0, -2, 0
Local tex:TTexture = LoadTexture("../media/Moss.bmp")
EntityTexture(plane, tex)

Local shared:TClone=New TClone

shared.mesh=LoadAnimMesh("../media/Ork.b3d")
MoveEntity shared.mesh,-10,-1.75,-10

Local maxclones%=29, starttime%=MilliSecs(), endtime%

' used by fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

Local shadow:TShadowObject=CreateShadow(shared.mesh)
Local orkwalk%=ExtractAnimSeq(shared.mesh,1,60)
Animate shared.mesh, 1, 1, orkwalk, 0

' main loop
While Not KeyDown( KEY_ESCAPE )

	If shared.clonecount<maxclones
		shared.thread=CreateThread(CloneOrk,shared) ' pass data to share between threads
		DetachThread(shared.thread) ' closes the thread handle immediately
	EndIf
	
	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	If KeyDown(KEY_I) And shared.mesh Then TurnEntity shared.mesh,0.5,0,0
	If KeyDown(KEY_K) And shared.mesh Then TurnEntity shared.mesh,-0.5,0,0
	If KeyDown(KEY_J) And shared.mesh Then TurnEntity shared.mesh,0,2.5,0
	If KeyDown(KEY_L) And shared.mesh Then TurnEntity shared.mesh,0,-2.5,0
	
	UpdateWorld
	RenderWorld
	
	If shared.clonecount=maxclones And ThreadRunning(shared.thread)=False ' wait for the last thread to finish
		For Local meshcopy:TMesh=EachIn shared.meshlist
			Animate meshcopy, 1, 1, 0, 0
		Next
		maxclones=0
		endtime=MilliSecs()-starttime
	EndIf
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()+", clones: "+shared.clonecount+", load time: "+endtime
	Text 0,40,"WASD/Arrows: move camera, IJKL: turn mesh"
	
	Flip
	
Wend

End

Type TClone ' store everything shared between threads
	Field mesh:TMesh
	Field meshlist:TList=CreateList()
	Field clonecount%=0, linecount%=0, nextline%=0
	Field thread:TThread
EndType

Function CloneOrk:Object(data:Object)

	If TryLockMutex(Mutex)
		Delay 10 ' tiny delay is needed to keep threads stable or they can crash
		
		TClone(data).clonecount:+1
		LoadOrk(TClone(data))
		
		UnlockMutex(mutex)
	EndIf
	
End Function

Function LoadOrk(data:Object)

	Local meshcopy:TMesh=TMesh(CopyEntity(TClone(data).mesh))
	TClone(data).linecount:+1
	If TClone(data).linecount>=10
		TClone(data).linecount=0
		TClone(data).nextline:+1
	EndIf
	MoveEntity meshcopy,TClone(data).linecount*2,0,TClone(data).nextline*2
	ListAddLast TClone(data).meshlist,meshcopy
	
End Function
