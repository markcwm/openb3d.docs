' msantialias.bmx
' Hardware multisample antialiasing (Windows) - needs custom brl.glgraphics module (by JoshK and John J)
' install: copy & paste the file in brl.glgraphics to brl.mod/glgraphics.mod, and rebuild brl.graphics as well

SuperStrict

Framework Openb3dmax.B3dglgraphics

Local width%=DesktopWidth()/1.0, height%=DesktopHeight()/1.0, depth%=0, Mode%=2, hertz%=60
Local flags%=GRAPHICS_BACKBUFFER|GRAPHICS_ALPHABUFFER|GRAPHICS_DEPTHBUFFER|GRAPHICS_STENCILBUFFER|GRAPHICS_ACCUMBUFFER

GLShareContexts() ' multiple contexts for 2 windows - the hidden window is needed to initialize multisample mode

SetGraphicsDriver GLMax2DDriver()
Local gfx_hidden:TGraphics=CreateGraphics( 300,200,0,60,GRAPHICS_BACKBUFFER|GRAPHICS_HIDDEN )
SetGraphics gfx_hidden ' need to call this before GetInfo() in windows
THardwareInfo.GetInfo() ' multisample flag has to be passed to graphics window

?win32
	If THardwareInfo.MultisampleSupport Then flags:|GRAPHICS_MULTISAMPLE2X Else DebugLog " Multisample antialiasing not found"
?macos
	DebugLog " Multisample antialiasing not supported"
?linux
	DebugLog " Multisample antialiasing not supported"
?

Graphics3D width,height,depth,mode,60,flags ' note: this function should only be called once

Local cam:TCamera=CreateCamera()
PositionEntity cam,0,0,-5

Local light:TLight=CreateLight(1)

Local tex:TTexture=LoadTexture("../media/test.png")

Local cube:TMesh=CreateCube()
Local sphere:TMesh=CreateSphere()
Local cylinder:TMesh=CreateCylinder()
Local cone:TMesh=CreateCone() 

PositionEntity cube,-3,0,0
PositionEntity sphere,-1,0,0
PositionEntity cylinder,1,0,0
PositionEntity cone,3,0,0

EntityTexture cube,tex
EntityTexture sphere,tex
EntityTexture cylinder,tex
EntityTexture cone,tex

' used by fps code
Local old_ms%=MilliSecs()
Local renders%
Local fps%

Local aa%=1


While Not KeyDown(KEY_ESCAPE)		

	If KeyHit(KEY_ENTER) Then DebugStop

	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
		
	If KeyHit(KEY_MINUS)
		aa=0 ' disable
		MSAntiAlias aa
	EndIf
	
	If KeyHit(KEY_EQUALS)
		aa=1 ' enable
		MSAntiAlias aa
	EndIf
	
	If KeyHit(KEY_2)
		flags=GRAPHICS_BACKBUFFER|GRAPHICS_ALPHABUFFER|GRAPHICS_DEPTHBUFFER|GRAPHICS_STENCILBUFFER|GRAPHICS_ACCUMBUFFER
	?win32
		If THardwareInfo.MultisampleSupport Then flg:|GRAPHICS_MULTISAMPLE2X ' avoids CreateGraphics fail if not supported
	?
		ReloadGraphics( width,height,depth,hertz,flags,gfx_hidden )
	EndIf
	
	If KeyHit(KEY_4)
		flags=GRAPHICS_BACKBUFFER|GRAPHICS_ALPHABUFFER|GRAPHICS_DEPTHBUFFER|GRAPHICS_STENCILBUFFER|GRAPHICS_ACCUMBUFFER
	?win32
		If THardwareInfo.MultisampleSupport Then flg:|GRAPHICS_MULTISAMPLE4X ' avoids CreateGraphics fail if not supported
	?
		ReloadGraphics( width,height,depth,hertz,flags,gfx_hidden )
	EndIf
	
	TurnEntity cube,0,1,0

	RenderWorld
	renders=renders+1
	
	' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps
	Text 0,40,"+/- to enable/disable AA, 2/4 to change MSAA level"
	Text 0,60,"MSAntiAlias: "+aa
	
	Flip

Wend
End

Function ReloadGraphics( wdt%,hgt%,dpt%,hrz%,flg%,hid:TGraphics Var )

		CloseGraphics hid
		CloseGraphics TGlobal3D.gfx_obj
		
		SetGraphicsDriver GLMax2DDriver()
		hid=CreateGraphics( 300,200,0,60,GRAPHICS_BACKBUFFER|GRAPHICS_HIDDEN )
		SetGraphics hid
		
		SetGraphicsDriver GLMax2DDriver(),flg ' mixed 2d/3d
		TGlobal3D.gfx_obj=Graphics( wdt,hgt,dpt,hrz,flg ) ' gfx object
		TGlobal3D.GraphicsInit() ' save initial settings for Max2D
		
End Function
