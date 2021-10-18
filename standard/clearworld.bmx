' clearworld.bmx

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

'UseLibraryMeshes 1 ' crashes with library meshes
'UseLibraryTextures 1

Local scene:TScene=New TScene
scene.LoadScene()

While Not KeyDown(KEY_ESCAPE)

	scene.UpdateScene()
	
Wend
End

Type TScene

	Field camera:TCamera
	Field light:TLight
	Field anim:TMesh
	Field cube:TMesh
	Field cube2:TMesh
	Field cone:TMesh
	Field plane:TMesh
	Field tex0:TTexture
	Field tex1:TTexture
	Field tex2:TTexture
	Field brush:TBrush
	Field surf:TSurface
	Field brush2:TBrush
	Field tex3:TTexture
	
	Method LoadScene()
	
		camera=CreateCamera()
		
		light=CreateLight()
		
		anim=LoadAnimMesh("../media/zombie.b3d")
		PositionEntity anim,3,-0.5,10
		ScaleEntity anim,0.4,0.4,0.4
		
		cube=CreateCube()
		PositionEntity cube,-1.5,0,4
		
		cube2=CreateCube()
		PositionEntity cube2,1.5,0,4
		
		cone=LoadAnimMesh("../media/lo_perpix.b3d")
		
		PositionEntity cone,-3,-0.5,10
		ScaleEntity cone,0.4,0.4,0.4
		
		plane=CreateCube()
		ScaleEntity plane,10,0.1,10
		MoveEntity plane,0,-1.5,0
		
		tex0=LoadTexture("../media/spark.png",1+2)
		EntityTexture cube,tex0,0,0
		tex1=LoadTexture("../media/tex1.jpg",1)
		EntityTexture cube,tex1,0,1
		tex2=LoadTexture("../media/tex2.jpg",1)
		EntityTexture cube,tex2,0,2
		
		brush=CreateBrush()
		surf=GetSurface(cube,1)
		BrushBlend surf.brush,3
		
		brush2=LoadBrush("../media/Moss.bmp" )
		'surf=GetSurface(plane,1)
		'PaintSurface surf,brush2
		PaintMesh plane,brush2
		
		tex3=LoadTexture("../media/alpha_map.png",1)
		EntityTexture cube2,tex3
		EntityFX(cube2,32)
		
		Animate anim,1,0.2,0,0
		
	End Method
	
	Method UpdateScene()
	
		' control camera
		TurnEntity camera,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
		
		TurnEntity cube,0,-0.5,0.1
		TurnEntity cube2,0,0.5,-0.1
		
		UpdateWorld
		RenderWorld
		
		Text 0,20,"Enter: ClearWorld"
		
		Flip
		
		If KeyHit(KEY_ENTER)
			Local oldtime%=MilliSecs()
			ClearWorld(1,1,1)
			DebugLog " clear time: "+Abs(MilliSecs()-oldtime)
			
			camera=Null
			light=Null
			anim=Null
			cube=Null
			cube2=Null
			cone=Null
			plane=Null
			tex0=Null
			tex1=Null
			tex2=Null
			brush=Null
			surf=Null
			brush2=Null
			tex3=Null
			GCCollect()
			
			oldtime%=MilliSecs()
			LoadScene()
			DebugLog " load time: "+Abs(MilliSecs()-oldtime)
		EndIf
		
	End Method

End Type
