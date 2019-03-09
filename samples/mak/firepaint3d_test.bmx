' firepaint3d_test.bmx
' note: this code isn't finished

Strict

Framework Openb3dmax.B3dglgraphics
Include "TBatchSprite2.bmx"

Local width=640,height=480,depth=0,mode=2

Graphics3D width,height,depth,mode

AmbientLight 0,0,0

Const grav#=-.02,intensity=5

Type Frag
	Field ys#,alpha#,entity:TBatchSprite2
End Type

Local fraglist:TList=CreateList()

Local pivot:TPivot=CreatePivot()

Local camera:TCamera=CreateCamera(pivot)
CameraClsMode camera,False,True

Local camera2:TCamera=CreateCamera(pivot)
RotateEntity camera2,90,0,0
CameraViewport camera2,0,0,100,100

'create blitzlogo 'cursor'
Local cursor:TMesh=CreateSphere(8,camera)
Local logotex:TTexture=LoadTexture("../media/blitzlogo.bmp")
EntityTexture cursor,logotex
MoveEntity cursor,0,0,25
EntityBlend cursor,3
EntityFX cursor,1

'create sky sphere
Local sky:TMesh=CreateSphere()
Local tex:TTexture=LoadTexture( "../media/stars.bmp" )
ScaleTexture tex,.125,.25
EntityTexture sky,tex
ScaleEntity sky,500,500,500
EntityFX sky,1
FlipMesh sky

TextureLoader "cpp"

'spark=LoadSprite("media/bluspark.bmp")
Local batch_controller:TBatchSpriteMesh2 = TBatchSprite2.LoadBatchTexture("../media/bluspark.bmp") ' loads into batch 0

Local time=MilliSecs()
Local num%

' used by fps code
Local old_ms=MilliSecs()
Local renders
Local fps

MoveMouse 0,0

While Not KeyDown(KEY_ESCAPE)

	'Repeat
		Local elapsed=MilliSecs()-time
	'Until elapsed>0
	
	time=time+elapsed
	Local dt#=elapsed*60.0/1000.0
	
	Local x_speed#,y_speed#
	
	x_speed=((MouseX()-320)-x_speed)/4+x_speed
	y_speed=((MouseY()-240)-y_speed)/4+y_speed
	MoveMouse 320,240

	TurnEntity pivot,0,-x_speed,0	'turn player Left/Right
	TurnEntity camera,-y_speed,0,0	'tilt camera
	TurnEntity cursor,0,dt*5,0
	
	TBatchSprite2.BatchSpriteEntity().PositionEntity (cursor.EntityX(1), cursor.EntityY(1),cursor.EntityZ(1))
	
	If MouseDown(1)
		For Local t%=1 To intensity *3
			Local f:Frag=New Frag
			f.ys=0
			f.alpha=Rnd(2,3)
			'f.entity=CopyEntity( spark,cursor )
			f.entity=TBatchSprite2.CreateBatchSprite(cursor)
			SpriteRenderMode f.entity,1
			SpriteViewMode f.entity,1
			
			ShowEntity f.entity
			EntityColor f.entity,Rnd(255),Rnd(255),Rnd(255)
			EntityParent f.entity,Null
			RotateEntity f.entity,Rnd(360),Rnd(360),Rnd(360)
			
			num=num+1
			ListAddLast(fraglist,f)
		Next
	EndIf
	
	Local n_parts%=0
	Local n_surfs%=0
	For Local f:Frag=EachIn Fraglist
		f.alpha=f.alpha-dt*.01
		If f.alpha>0
			Local al#=f.alpha
			If al>1 Then al=1
			EntityAlpha f.entity,al
			MoveEntity f.entity,0,0,dt*.4
			
			Local ys#=f.ys+grav*dt
			Local dy#=f.ys*dt
			f.ys=ys
			TranslateEntity f.entity,0,dy,0
		Else
			FreeEntity f.entity
			ListRemove(fraglist,f)
			num=num-1
		EndIf
	Next
	
	'UpdateWorld
	RenderWorld
	renders=renders+1

	' calculate fps
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+String(fps)+" "+num

	Flip
Wend

End

