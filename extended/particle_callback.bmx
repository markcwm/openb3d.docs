' particle_callback.bmx
' particle emitter callback function: add custom alpha, scaling and randomness to particles

Strict

Framework Openb3dmax.B3dglgraphics
Import Brl.Random

Graphics3D DesktopWidth(), DesktopHeight(), 0, 2

ClearTextureFilters
SeedRnd MilliSecs()

Local cam:TCamera = CreateCamera()
CameraClsColor cam, 80, 160, 240
PositionEntity cam, 0.1, 3, -5

Local light:TLight=CreateLight()

Local ground:TMesh=CreateCube()
ScaleEntity ground, 1000, 1, 1000
Local ground_tex:TTexture=LoadTexture("../media/sand.bmp")
ScaleTexture ground_tex, 0.01, 0.01 ' scale uvs
EntityTexture ground, ground_tex

Local sphere:TMesh=CreateSphere()
PositionEntity sphere, 1.5, 2.1, 10
EntityColor sphere, 127, 127, 12
EntityAlpha sphere, 0.5

Local sphere2:TMesh=CreateSphere()
PositionEntity sphere2, -0.5, 2.1, 1
EntityColor sphere2, 12, 127, 127
EntityAlpha sphere2, 0.5
EntityFX sphere2, 32

TParticleFunc.Scale(3.0, 3.0, 0.5, 1.5) ' set scale x/y and min/max
TParticleFunc.Life(40, 60) ' set life min/max

Local sprite:TSprite=CreateSprite()
EntityColor sprite, 225, 225, 200
EntityAlpha sprite, 0.5
ScaleSprite sprite, TParticleFunc.scalex, TParticleFunc.scaley
Local noisetex:TTexture=LoadTexture("../media/Smoke2.png", 1+2)
EntityTexture sprite, noisetex
HideEntity sprite

Local pe:TParticleEmitter=CreateParticleEmitter(sprite)
MoveEntity pe, 0, 5, 0
TurnEntity pe, -90, 0, 0

EmitterRate pe, 1.0
EmitterParticleLife pe, TParticleFunc.life_max
EmitterVariance pe, 0.07
EmitterParticleSpeed pe, 0.1
EmitterParticleFunction pe, TParticleFunc.Callback ' point to callback

Local efx%=1

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%


While Not KeyHit(KEY_ESCAPE)

	' move emitter, position particles
	PositionEntity pe, Sin(MilliSecs() * 0.05) * 4, 3, 5
	
	' control camera
	MoveEntity cam, KeyDown(KEY_D)-KeyDown(KEY_A), 0, KeyDown(KEY_W)-KeyDown(KEY_S)
	TurnEntity cam, KeyDown(KEY_DOWN)-KeyDown(KEY_UP), KeyDown(KEY_LEFT)-KeyDown(KEY_RIGHT), 0
	
	' alpha blend sphere
	If KeyHit(KEY_B)
		efx=Not efx
		If efx
			EntityAlpha(sphere, 0.5) ; EntityFX(sphere, 32)
			EntityAlpha(sphere2, 0.5) ; EntityFX(sphere2, 32)
		Else
			EntityAlpha(sphere, 1) ; EntityFX(sphere, 0)
			EntityAlpha(sphere2, 1) ; EntityFX(sphere2, 0)
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
	
	Text 0, 20, "FPS: "+fps+", Memory: "+GCMemAlloced()
	Text 0, 40, "Arrows/WASD: move camera, B: alpha blend spheres"
	
	Flip
	GCCollect
	
Wend

TParticleFunc.Free(pe) ' free particles
GCCollect
DebugLog " Memory at end="+GCMemAlloced()

End


Type TParticleData

	?bmxng
	Global map:TPtrMap=New TPtrMap
	?Not bmxng
	Global map:TMap=New TMap
	?
	
	Field inst:Byte Ptr, life%
	Field spr:TSprite
	Field life_minmax%, life_max%
	Field scale_minmax#
	
	Function SetObject:TParticleData( inst:Byte Ptr,obj:TParticleData )
	
		If inst=Null Then Return Null
		?bmxng
		TParticleData.map.Insert( inst,obj )
		?Not bmxng
		TParticleData.map.Insert( String(Int(inst)),obj )
		?
		
	End Function
	
	Function GetObject:TParticleData( inst:Byte Ptr )
	
		?bmxng
		Return TParticleData( map.ValueForKey( inst ) )
		?Not bmxng
		Return TParticleData( map.ValueForKey( String(Int(inst)) ) )
		?
		
	End Function
	
End Type

Type TParticleFunc

	Global nparticles%
	Global life_min%, life_max%
	Global scalex#, scaley#, scale_min#, scale_max#
	
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
	
	Function Free( pe:TParticleEmitter )
	
		TParticleData.map.Clear() ' no ClearMap in PtrMap
		FreeEntity pe
		
	End Function
	
	' store inst in map (for quick lookup) along with type for per instance data
	Function UpdateMap:TParticleData( inst:Byte Ptr,life:Int )
	
		Local inlist%=0, pd:TParticleData
		pd=TParticleData.GetObject(inst)
		If pd<>Null
			If inst=TSprite.GetInstance(pd.spr) Then inlist=True
		EndIf
		
		If inlist=False ' init particle data, this is where to add randomness
			pd=New TParticleData
			pd.spr=TSprite.CreateObject(inst)
			pd.life_minmax=Rand(life_min, life_max)
			pd.life_max=life_max + (life_max / 10) ' life + 5% (max more than life so alpha will be < 1)
			pd.scale_minmax=Rnd(scale_min, scale_max)
			TParticleData.SetObject(inst, pd)
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
	
		Local pd:TParticleData=UpdateMap(inst, life)
		UpdateLife(pd)
		UpdateAlpha(pd)
		UpdateScale(pd)
		
	End Function
	
	Function UpdateLife( pd:TParticleData )
	
		If (life_max - pd.life) > pd.life_minmax Then HideEntity(pd.spr) ' randomize life
		
	End Function
	
	Function UpdateAlpha( pd:TParticleData )
	
		Local lifeleft#=Float(pd.life) / pd.life_max ' normalized - 0..1
		EntityAlpha pd.spr, lifeleft ' to use wrapper function
		
		'DebugLog "lifeleft="+lifeleft+" life="+pd.life+" max="+pd.life_max
	End Function
	
	Function UpdateScale( pd:TParticleData )
	
		Local lifegone#=Float(pd.life_minmax - pd.life) / pd.life_max ' normalized - 1..0
		Local sx#=(scalex + lifegone) * pd.scale_minmax
		Local sy#=(scaley + lifegone) * pd.scale_minmax
		ScaleSprite pd.spr, sx, sy
		
		'DebugLog "lifegone="+lifegone+" sx="+sx+" life="+pd.life
	End Function
	
End Type
