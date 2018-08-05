' ssao.bmx
' postprocess effect - Screen Space Ambient Occlusion

Strict

Framework Openb3dMax.B3dglgraphics
Import Brl.Random
?Not bmxng
Import Brl.Timer
?bmxng
Import Brl.TimerDefault
?

'Local width%=DesktopWidth(),height%=DesktopHeight()
Local width%=800,height%=600

Graphics3D width,height,0,2

SeedRnd MilliSecs()
ClearTextureFilters ' remove mipmap flag for postfx texture

Global camera:TCamera=CreateCamera()
CameraRange camera,0.5,1000.0 ' near must be closer than screen sprite to prevent clipping
CameraClsColor camera,150,200,250

Global postfx_cam:TCamera=CreateCamera() ' copy main camera
CameraRange postfx_cam,0.5,1000.0
CameraClsColor postfx_cam,150,200,250
HideEntity postfx_cam

Local light:TLight=CreateLight()
TurnEntity light,45,45,0

Local size:Int=256, vsize:Float=30, maxheight:Float=10
Local terrain:TTerrain=LoadTerrain("../media/heightmap_256.BMP") ' path case-sensitive on Linux
ScaleEntity terrain,1,(1*maxheight)/vsize,1 ' set height
terrain.UpdateNormals() ' correct lighting
PositionEntity terrain,-size/2,-10,size/2

' Texture terrain
Local grass_tex:TTexture=LoadTexture( "../media/terrain-1.jpg" )
EntityTexture terrain,grass_tex
ScaleTexture grass_tex,10,10

Local pivot:TPivot=CreatePivot()
PositionEntity pivot,0,0,0
Local anim_time:Float
Local anim_ent:TMesh=LoadAnimMesh("../media/zombie.b3d",pivot)
PositionEntity anim_ent,0,0,12
TurnEntity anim_ent,0,-90,0

Local cube:TMesh=LoadMesh("../media/wcrate1.3ds")
ScaleMesh cube,0.15,0.15,0.15
PositionEntity cube,0,3,0
Local cube_tex:TTexture=LoadTexture("../media/crate.bmp",1)
EntityTexture cube,cube_tex
TurnEntity cube,0,45,0

' Add 4 more
Local c1:TEntity = CopyEntity(cube)
PositionEntity c1,5,0,5
Local c2:TEntity = CopyEntity(cube)
PositionEntity c2,-5,0,-5
Local c3:TEntity = CopyEntity(cube)
PositionEntity c3,5,0,-5
Local c4:TEntity = CopyEntity(cube)
PositionEntity c4,-5,0,5

Global colortex:TTexture=CreateTexture(width,height,1+256)
ScaleTexture colortex,1.0,-1.0

Global depthtex:TTexture=CreateTexture(width,height,1+256)
ScaleTexture depthtex,1.0,-1.0

' in GL 2.0 render textures need attached before other textures (EntityTexture)
CameraToTex colortex,camera
DepthBufferToTex depthtex,camera
TGlobal.CheckFramebufferStatus(GL_FRAMEBUFFER_EXT) ' check for framebuffer errors

' screen sprite - by BlitzSupport
Global screensprite:TSprite=CreateSprite()
EntityOrder screensprite,-1
ScaleSprite screensprite,1.0,Float( GraphicsHeight() ) / GraphicsWidth() ' 0.75
MoveEntity screensprite,0,0,1.0 ' set z to 0.99 - instead of clamping uvs
EntityParent screensprite,camera

Global screensprite2:TSprite=CreateSprite()
ScaleSprite screensprite2,1.0,Float( GraphicsHeight() ) / GraphicsWidth() ' 0.75
EntityOrder screensprite2,-1
EntityParent screensprite2,camera
MoveEntity screensprite2,0,0,1.0 ' set z to 1.0
EntityTexture screensprite2,depthtex

PositionEntity camera,0,7,0 ' move camera now sprite is parented to it
MoveEntity camera,0,0,-25

Local shader:TShader=LoadShader("","../glsl/default.vert.glsl", "../glsl/ssao.frag.glsl")

Local toggle:Int = 0

ShaderTexture(shader,colortex,"colortex",0) ' Our render texture
ShaderTexture(shader,depthtex,"depthtex",1) ' 1 is depth texture
SetFloat(shader,"width", width)
SetFloat(shader,"height", height)
SetFloat(shader,"near", 1.0)
SetFloat(shader,"far", 1000.0)
SetInteger(shader,"samples", 5)
SetInteger(shader,"rings", 3)
UseInteger(shader,"onlyAO", toggle)
ShadeEntity(screensprite, shader)

Global postprocess%=1

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%

Local update% = 1

While Not KeyHit(KEY_ESCAPE)

	If KeyHit(KEY_TAB) Then toggle = Not toggle
	
	'time=Float((TimerTicks(timer) / framerate) * animspeed)
	
	If KeyDown(KEY_MINUS) Then anim_time#=anim_time#-0.1
	If KeyDown(KEY_EQUALS) Then anim_time#=anim_time#+0.1
	
	anim_time:+0.5
	If anim_time>20 Then anim_time=2
	SetAnimTime(anim_ent,anim_time)
	TurnEntity pivot,0,1,0
	
	If KeyHit(KEY_SPACE) Then postprocess=Not postprocess
	
	' control camera
	If KeyDown(KEY_RIGHT)=True Then MoveEntity camera,0.25,0,0
	If KeyDown(KEY_LEFT)=True Then MoveEntity camera,-0.25,0,0
	If KeyDown(KEY_DOWN)=True Then MoveEntity camera,0,0,-0.25
	If KeyDown(KEY_UP)=True Then MoveEntity camera,0,0,0.25
	If KeyDown(KEY_W)=True Then TurnEntity camera,-1,0,0
	If KeyDown(KEY_S)=True Then TurnEntity camera,1,0,0
	If KeyDown(KEY_A)=True Then TurnEntity camera,0,1,0
	If KeyDown(KEY_D)=True Then TurnEntity camera,0,-1,0
	
	PositionEntity postfx_cam,EntityX(camera),EntityY(camera),EntityZ(camera)
	RotateEntity postfx_cam,EntityPitch(camera),EntityYaw(camera),EntityRoll(camera)
	
	If KeyHit(KEY_Q) Then update=Not update
	
	UpdateWorld
	
	While update = 0
		If KeyHit(KEY_TAB) Then toggle = Not toggle
		If KeyHit(KEY_SPACE) Then postprocess=Not postprocess
		If KeyHit(KEY_Q) Then update=Not update
	Wend
	
	Update1Pass()
	
	' calculate fps
	renders=renders+1
	If MilliSecs()-old_ms>=1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Space: postprocess = "+postprocess
	Text 0,60,"Tab: Toggle SSAO only = "+toggle
	Text 0,80,"Q: Pause"
	Text 0,100,"anim_time="+anim_time
	
	Flip
	GCCollect
Wend
End


Function Update1Pass()

	If postprocess=0
		HideEntity postfx_cam
		ShowEntity camera
		HideEntity screensprite2
		HideEntity screensprite
		
		RenderWorld
	ElseIf postprocess=1
		HideEntity camera
		ShowEntity postfx_cam
		HideEntity screensprite2
		HideEntity screensprite
		
		CameraToTex colortex,postfx_cam
		
		HideEntity postfx_cam
		ShowEntity camera
		
		DepthBufferToTex depthtex,camera
		
		ShowEntity screensprite
		
		RenderWorld
	EndIf
	
End Function
