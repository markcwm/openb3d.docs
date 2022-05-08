' loadmesh_threads.bmx
' using CopyEntity in threads, tutorial credit to TomToad

Strict

Framework Openb3d.B3dglgraphics

Global Mutex:TMutex=CreateMutex() ' create the mutex, this will be locked anytime a thread needs access
Global Cond:TCondVar=CreateCondVar() ' create a condition, this signals a thread to continue
Global clonecount%=0, linecount%=0, nextline%=0

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

Global meshlist:TList=CreateList() ' list to store clones
Global mesh:TMesh=LoadAnimMesh("../media/Ork.b3d")
MoveEntity mesh,-10,-1.75,-10

Local maxclones%=29, once%=0
For Local i%=1 To maxclones
	Local thread:TThread=CreateThread(CloneOrk,mesh)
	DetachThread(thread) ' closes the thread handle immediately, the alternative is WaitThread
Next

' used by fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

Local shadow:TShadowObject=CreateShadow(mesh)
Local orkwalk%=ExtractAnimSeq(mesh,1,60)
Animate mesh, 1, 1, orkwalk, 0

' main loop
While Not KeyDown( KEY_ESCAPE )

	' control camera
	MoveEntity camera,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	If KeyDown(KEY_I) And mesh Then TurnEntity mesh,0.5,0,0
	If KeyDown(KEY_K) And mesh Then TurnEntity mesh,-0.5,0,0
	If KeyDown(KEY_J) And mesh Then TurnEntity mesh,0,2.5,0
	If KeyDown(KEY_L) And mesh Then TurnEntity mesh,0,-2.5,0
	
	If clonecount=maxclones And once=0 ' when all clones have loaded
		once=1
		For Local meshcopy:TMesh=EachIn meshlist
			Animate meshcopy, 1, 1, 0, 0
		Next
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
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()+", clones: "+clonecount
	Text 0,40,"WASD/Arrows: move camera, IJKL: turn mesh"
	
	Flip
	
Wend

End


Function CloneOrk:Object(data:Object)
	Delay 500 ' a short delay is needed for thread to finish or it will crash
	LockMutex(Mutex) 'Lock the mutex so we can have exclusive access to th
	
	Local meshcopy:TMesh=TMesh(CopyEntity(TMesh(data)))
	linecount:+1
	If linecount>=10 Then linecount=0 ; nextline:+1
	MoveEntity meshcopy,linecount*2,0,nextline*2
	clonecount:+1
	ListAddLast meshlist,meshcopy
	
	BroadcastCondVar(Cond) 'Broadcast all threads to continue
	WaitCondVar(Cond,Mutex) 'Wait for the condition to be signaled before continuing
	UnlockMutex(mutex) 'unlock the mutex to allow other threads access
End Function
