' Deltatime.bmx
' by Kippykip - http://www.youtube.com/user/HAP3E
' The box should rotate at the same speed. Use mouse buttons to cap frame rate. Press Z to go slow motion

Strict
Framework Openb3dmax.B3dglgraphics
?Not bmxng
Import Brl.Timer
?bmxng
Import Brl.TimerDefault
?

Graphics3D DesktopWidth(),DesktopHeight(),0,2 ' Set the resolution

Local camera:TCamera=CreateCamera() ' Create the camera
CameraClsColor(camera, 0, 255, 200) ' Background colour
ClearTextureFilters() ' Get rid of the dumb texture filters

Local cube:TMesh=CreateCube() ' Create a cube
PositionEntity(cube, 0, 0, 4) ' Reposition the cube where you can see it
Local spin# = 2

Local light:TLight=CreateLight(1) ' Create a light

Local tex:TTexture=LoadTexture("../media/oldbric.jpg") ' Cube texture
EntityTexture(cube,tex) ' Apply the texture

' Target FPS 
Global DT:TDeltaTime = New TDeltaTime
DT.FrameLimitInit(60)

' Frame caps of 15, 30, and 60
Global cap:TTimer=CreateTimer(15)
Global cap2:TTimer=CreateTimer(30)
Global cap3:TTimer=CreateTimer(60)

' Define the Slow Motion value (default is 1 so the deltatime isn't changed when holding the SlowMo key)
Global SlowMo# = 1, framecap%

' main loop
While (Not KeyDown(KEY_ESCAPE))

	DT.FPSUpdate() ' Update FPS counter on titlebar
	DT.UpdateSpeedFactor() ' Update Deltatime
	
	' Now, everything that moves needs to be multiplied by the Deltatime's SpeedFactor and if you will be using the SlowMo
	' values, you need to divide it by the SlowMo afterwards like so: *(DT.SpeedFactor#/SlowMo)
	TurnEntity(cube, spin * (DT.SpeedFactor# / SlowMo), spin * (DT.SpeedFactor# / SlowMo), spin * (DT.SpeedFactor# / SlowMo))
	
	' Update the world using Deltatime and Slow Motion
	' (Unnecessary here, but if you have a project with models animations, do this!)
	UpdateWorld(DT.SpeedFactor# / SlowMo)
	RenderWorld() ' Render the world
	
	Text 0,20, " FPS: " + DT.FPS_Current#
	Text 0,40, " Keys 1/2: framerate cap = " + framecap + ", Z: slow motion = " + SlowMo
	
	' If you're holding the SlowMo Key
	If(KeyDown(KEY_Z))
		SlowMo = 16
	Else ' If you're not holding the SlowMo key
		SlowMo = 1 ' Reset the slowmotion to 1
	EndIf
	
	' Cap the framerate when holding these mouse buttons
	If(KeyDown(KEY_1))
		WaitTimer(cap)
		framecap = 15
	EndIf
	If(KeyDown(KEY_2))
		WaitTimer(cap2)
		framecap = 30
	EndIf
	' If you're not holding down anything, cap to 60
	If(KeyDown(KEY_1) = False And KeyDown(KEY_2) = False)
		WaitTimer(cap3)
		framecap = 60
	EndIf
	
	Flip False ' Flip the BackBuffer without VSync
Wend

End

' functions
Type TDeltaTime

	' FPS counter values for the titlebar
	Global FPS_FrameCount# = 0
	Global FPS_MilliCount# = MilliSecs()
	Global FPS_Current# = 60
	Global sync# = 1
	
	' Delta Time FPS measuring
	Field TargetFPS#	
	Field SpeedFactor#
	Field FPS#	
	Field TicksPerSecond%
	Field CurrentTicks%
	Field FrameDelay%
	
	' This is the FPS counter on the Window Title
	Function FPSUpdate()
		FPS_FrameCount = FPS_FrameCount + 1
		If(MilliSecs() - FPS_MilliCount >= 1000)
			FPS_Current = FPS_FrameCount
			FPS_FrameCount = 0
			FPS_MilliCount = MilliSecs()
			sync# = 60 / FPS_Current#
		EndIf
	End Function
	
	' I don't remember how this works anymore so I can't explain it. Got it somewhere from the code archives.
	Method FrameLimitInit(target_FPS#)
		TargetFPS# = target_FPS#
		TicksPerSecond = 1000 	
		FrameDelay = MilliSecs()
	End Method
	
	Method UpdateSpeedFactor()
		CurrentTicks = MilliSecs()
		SpeedFactor = (CurrentTicks - FrameDelay) / (TicksPerSecond / TargetFPS) 
		FPS = TargetFPS / SpeedFactor    
		FrameDelay = CurrentTicks 
	End Method
	
EndType
