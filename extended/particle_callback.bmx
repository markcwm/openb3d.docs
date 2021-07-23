' particle_callback.bmx
' particle emitter callback function: add custom alpha, scaling and randomness to particles

Strict

Framework Openb3dmax.B3dglgraphics

?Not bmxng
Import Brl.Random
?bmxng
Import Brl.RandomDefault ' since v0.121
?

Graphics3D DesktopWidth(),DesktopHeight(),0,2

ClearTextureFilters
SeedRnd MilliSecs()

Local cam:TCamera = CreateCamera()
CameraClsColor cam,80,160,240
PositionEntity cam,0.1,3,-5

Local light:TLight=CreateLight()

Local ground:TMesh=CreateCube()
ScaleEntity ground,1000,1,1000
Local ground_tex:TTexture=LoadTexture("../media/sand.bmp")
ScaleTexture ground_tex,0.01,0.01 ' scale uvs
EntityTexture ground,ground_tex
HideEntity ground

Local sphere:TMesh=CreateSphere()
PositionEntity sphere,1.5,2.1,10
EntityColor sphere,127,127,12
EntityAlpha sphere,0.75

Local sphere2:TMesh=CreateSphere()
PositionEntity sphere2,-0.5,2.1,1
EntityColor sphere2,12,127,127
EntityAlpha sphere2,0.75
EntityFX sphere2,32

TParticle.Scale(3.0,3.0,0.5,1.5) ' set scale x/y and min/max
TParticle.Life(40,60) ' set life min/max

Local sprite:TSprite=CreateSprite()
EntityColor sprite,225,225,200
EntityAlpha sprite,0.75
ScaleSprite sprite,TParticle.scalex,TParticle.scaley
Local noisetex:TTexture=LoadTexture("../media/Smoke2.png",1+2)
EntityTexture sprite,noisetex
'HideEntity sprite

SpriteRenderMode sprite,2 ' 2=batch sprites
SpriteViewMode sprite,1 ' face camera

Local pe:TParticleEmitter=CreateParticleEmitter(sprite)
MoveEntity pe,0,5,0
TurnEntity pe,-90,0,0

EmitterRate pe,1.0
EmitterParticleLife pe,TParticle.life_max
EmitterVariance pe,0.07
EmitterParticleSpeed pe,0.1
EmitterParticleFunction pe,TParticle.Callback ' point to callback

PositionEntity sprite,-10,3,10

Local efx%=1

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%


While Not KeyHit(KEY_ESCAPE)

	' move emitter, position particles
	PositionEntity pe,Sin(MilliSecs() * 0.1) * 4,3,5
	
	' control camera
	MoveEntity cam,KeyDown(KEY_D)-KeyDown(KEY_A),0,KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam,KeyDown(KEY_DOWN)-KeyDown(KEY_UP),KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT),0
	
	' alpha blend sphere
	If KeyHit(KEY_B)
		efx=Not efx
		If efx
			EntityAlpha(sphere,0.75) ; EntityFX(sphere,32)
			EntityAlpha(sphere2,0.75) ; EntityFX(sphere2,32)
		Else
			EntityAlpha(sphere,1) ; EntityFX(sphere,0)
			EntityAlpha(sphere2,1) ; EntityFX(sphere2,0)
		EndIf
	EndIf
	
	' update particles
	UpdateWorld
	RenderWorld
	
	' calculate fps
	renders=renders+1
	If Abs(MilliSecs() - old_ms) >= 1000
		old_ms=MilliSecs()
		fps=renders
		renders=0
	EndIf
	
	Text 0,20,"FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0,40,"Arrows/WASD: move camera, B: alpha blend spheres"
	
	Flip
	GCCollect
	
Wend

FreeEntity sprite
TParticle.FreeParticles(pe)

End


Type TParticleObject

	?bmxng
	Global map:TPtrMap=New TPtrMap
	?Not bmxng
	Global map:TMap=New TMap
	?
	Field instance:Byte Ptr
	
	Field inst:Byte Ptr, life%
	Field spr:TSprite
	Field life_minmax%, life_max%
	Field scale_minmax#
	
	Function CreateObject:TParticleObject( inst:Byte Ptr )
	
		If inst=Null Then Return Null
		Local obj:TParticleObject=New TParticleObject
		?bmxng
		map.Insert( inst,obj )
		?Not bmxng
		map.Insert( String(Int(inst)),obj )
		?
		obj.instance=inst
		Return obj
		
	End Function
	
	Function GetObject:TParticleObject( inst:Byte Ptr )
	
		?bmxng
		Return TParticleObject( map.ValueForKey( inst ) )
		?Not bmxng
		Return TParticleObject( map.ValueForKey( String(Int(inst)) ) )
		?
		
	End Function
	
End Type

Type TParticle

	Global nparticles%
	Global life_min%, life_max%
	Global scalex#, scaley#, scale_min#, scale_max#
	Global spr_list:TList=CreateList()
	
	Function Life( lmin#,lmax# )
	
		life_min=lmin
		life_max=lmax
		
	End Function
	
	Function Scale( sx#,sy#,smin#,smax# )
	
		scalex=sx
		scaley=sy
		scale_min=smin
		scale_max=smax
		
	End Function
	
	Function FreeParticles( pe:TParticleEmitter )
	
		TParticleObject.map.Clear() ' no ClearMap in PtrMap
		FreeEntity pe
		
		For Local spr:TSprite=EachIn spr_list
			If spr.exists '	we can't use FreeEntity on batch sprites
				spr.FreeEntityList()
				spr.exists=0
			EndIf
		Next
		
	End Function
	
	' store inst in map (for quick lookup) along with type for per instance data
	Function UpdateMap:TParticleObject( inst:Byte Ptr,life:Int )
	
		Local inlist%=0, pd:TParticleObject
		pd=TParticleObject.GetObject(inst)
		If pd<>Null
			If inst=TSprite.GetInstance(pd.spr) Then inlist=True
		EndIf
		
		If inlist=False ' init particle data, this is where to add randomness
			pd=TParticleObject.CreateObject(inst)
			pd.spr=TSprite.CreateObject(inst)
			ListAddLast spr_list,pd.spr
			
			pd.life_minmax=Rand(life_min,life_max)
			pd.life_max=life_max + (life_max / 10) ' life + 10% (max is more than life so alpha will be < 1)
			pd.scale_minmax=Rnd(scale_min,scale_max)
			nparticles:+1
			
			'DebugLog "nparticles="+nparticles
		EndIf
		
		If pd<>Null
			pd.inst=inst
			pd.life=life
		EndIf
		Return pd
		
	End Function
	
	Function Callback( inst:Byte Ptr,life:Int ) ' inst is sprite, life left
	
		Local pd:TParticleObject=UpdateMap(inst,life)
		UpdateLife(pd)
		UpdateAlpha(pd)
		UpdateScale(pd)
		
	End Function
	
	Function UpdateLife( pd:TParticleObject )
	
		If (life_max - pd.life) > pd.life_minmax
			HideEntity pd.spr ' randomize life
		EndIf
		
	End Function
	
	Function UpdateAlpha( pd:TParticleObject )
	
		Local lifeleft#=Float(pd.life) / pd.life_max ' normalized - 0..1
		EntityAlpha pd.spr,lifeleft ' to use wrapper function
		
		'DebugLog "lifeleft="+lifeleft+" life="+pd.life+" max="+pd.life_max
	End Function
	
	Function UpdateScale( pd:TParticleObject )
	
		Local lifegone#=Float(pd.life_minmax - pd.life) / pd.life_max ' normalized - 1..0
		Local sx#=(scalex + lifegone) * pd.scale_minmax
		Local sy#=(scaley + lifegone) * pd.scale_minmax
		ScaleSprite pd.spr,sx,sy
		
		'DebugLog "lifegone="+lifegone+" sx="+sx+" life="+pd.life
	End Function
	
End Type
