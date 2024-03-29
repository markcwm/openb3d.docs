' CreateTerrain.bmx

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight()

Local size:Int=2048, vsize:Float=30, maxheight:Float=10
Local camx:Float=size/2, camz:Float=-size/2

Local camera:TCamera=CreateCamera()
CameraClsColor camera,150,200,250
PositionEntity camera,0,maxheight+1,0

'Local spiv:TMesh=CreateSphere(8,camera)

TurnEntity camera,0,215,0

Local light:TLight=CreateLight()
RotateEntity light,90,0,0

Local sphere:TMesh=CreateSphere()
PositionEntity sphere,camx,maxheight,camz



' Create terrain
Local terrain:TTerrain=CreateTerrain(size)

Local map:TPixmap=LoadPixmap("../media/heightmap_256.BMP")
For Local iy%=0 To PixmapWidth(map)-1
	For Local ix%=0 To PixmapHeight(map)-1
		Local height:Float=ReadPixel(map,ix,iy) & $FF
		height=height/255 ' 255 to 1, 1=30M
		'ModifyTerrain terrain,ix,iy,(height*maxheight)/vsize
	Next
Next

terrain.UpdateNormals() ' correct lighting

' Texture terrain
Local grass_tex:TTexture=LoadTexture( "../media/terrain-1.jpg" )
EntityTexture terrain,grass_tex
ScaleTexture grass_tex,10,10

Local terrain2:TTerrain=LoadTerrain("../media/heightmap_256.BMP") ' path case-sensitive on Linux
ScaleEntity terrain2,1,(1*maxheight)/vsize,1 ' set height
terrain2.UpdateNormals() ' correct lighting
'terrain.UpdateTerrain()
'TTerrain.CopyArray_(TTerrain.vertices)
'TTerrain.DebugGlobals()

' Texture terrain
Local grass_tex2:TTexture=LoadTexture( "../media/sand.bmp" )
EntityTexture terrain2,grass_tex2
'ScaleTexture grass_tex,10,10
MoveEntity terrain,100,0,100

Local terra_detail:Int=100 ' Set terrain detail level, maximum is 2000
Local wiretoggle%=-1
Local range#=0

While Not KeyDown( KEY_ESCAPE )

	' wireframe
	If KeyHit(KEY_W) Then wiretoggle=-wiretoggle
	If wiretoggle=1 Then Wireframe True Else Wireframe False
	
	' Change terrain detail value depending on key pressed
	If KeyHit( KEY_OPENBRACKET ) Then terra_detail=terra_detail-10
	If KeyHit( KEY_CLOSEBRACKET ) Then terra_detail=terra_detail+10
	TerrainDetail terrain,terra_detail
	
	' Change terrain camera range
	If KeyDown(KEY_EQUALS) Then range:+1
	If KeyDown(KEY_MINUS) Then range:-1
	TerrainRange terrain,range
	
	If KeyDown( KEY_RIGHT )=True Then TurnEntity camera,0,-1,0
	If KeyDown( KEY_LEFT )=True Then TurnEntity camera,0,1,0
	If KeyDown( KEY_DOWN )=True Then MoveEntity camera,0,0,-0.25
	If KeyDown( KEY_UP )=True Then MoveEntity camera,0,0,0.25
	If KeyDown( KEY_PAGEUP )=True Then MoveEntity camera,0,0.25,0
	If KeyDown( KEY_PAGEDOWN )=True Then MoveEntity camera,0,-0.25,0
	
	RenderWorld
	
	Text 0,20,"Use cursor keys to move about the terrain "+EntityDistance(camera,sphere)
	Text 0,40,"Use [ and ] keys to change terrain detail level = "+terrain.Roam_Detail[0]+", range = "+range
	Text 0,60,"X = "+EntityX(camera)+", Y = "+EntityY(camera)+", Z = "+EntityZ(camera)
	Text 0,80,"size = "+terrain.size[0]+", lmax = "+Int((terrain.size[0]/100)+10)+", level2dzsize[0] = "+terrain.level2dzsize[0]
	Flip
Wend
End
