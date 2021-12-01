' particle_callback.bmx
' particle emitter callback for custom code such as alpha, scaling and randomness

Strict

Framework Openb3d.B3dglgraphics

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

TEmitter.SetScale(2.5,2.5,0.75,1.5) ' set start scale x/y and scale min/max
TEmitter.SetLife(40,60) ' set life min/max

Local sprite:TSprite=CreateSprite()
EntityColor sprite,225,225,200
EntityAlpha sprite,0.75
ScaleSprite sprite,TEmitter.scalex,TEmitter.scaley
Local noisetex:TTexture=LoadTexture("../media/Smoke2.png",1+2)
EntityTexture sprite,noisetex
'HideEntity sprite

SpriteRenderMode sprite,2 ' 2=batch sprites
SpriteViewMode sprite,1 ' face camera

Local emit:TParticleEmitter=CreateParticleEmitter(sprite)
MoveEntity emit,0,5,0
TurnEntity emit,-90,0,0 ' rotate to emit particles upwards

EmitterParticleLife emit,0,TEmitter.lifemax,0 ' set start and end life as the same
EmitterRate emit,1.01
EmitterVariance emit,0.07
EmitterParticleSpeed emit,0.1,0
EmitterParticleFunction emit,TEmitter.Callback ' point to callback function

' default functions get overridden by callback
'EmitterParticleAlpha emit,0.5,0.05 ' start and end alpha, 0..1
'EmitterParticleScale emit,12.0,2.0,0.5,0.5 ' start and end scale xy, default is 1

PositionEntity sprite,-10,3,10

Local efx%=1

' fps code
Local old_ms%=MilliSecs()
Local renders%, fps%


While Not KeyHit(KEY_ESCAPE)

	' move emitter to position particles
	PositionEntity emit,Sin(MilliSecs() * 0.1) * 4,3,5
	
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
	
	UpdateWorld ' update particles, actions, animations and collisions
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
	
Wend

FreeEntity sprite
TEmitter.FreeParticles(emit)

End


Type TParticle Extends TSprite

	Field life% ' lifespan left
	
	Field lifeend% ' max lifespan
	Field liferand% ' randomized lifespan
	Field scalerand# ' randomized scale
	
	' Creates a particle sprite
	Function CreateObject:TParticle( inst:Byte Ptr )
	
		If inst=Null Then Return Null
		Local obj:TParticle=New TParticle
		?bmxng
		ent_map.Insert( inst,obj )
		?Not bmxng
		ent_map.Insert( String(Int(inst)),obj )
		?
		obj.instance=inst
		Return obj
		
	End Function
	
End Type


Type TEmitter

	Global numparticles% ' number of particles
	
	Global lifemin%, lifemax% ' min/max lifespan
	Global scalex#, scaley# ' start scale x/y
	Global scalemin#, scalemax# ' min/max scale
	
	Global part_list:TList=CreateList() ' list of particles for this emitter
	
	' Set min/max random lifespan of particle
	Function SetLife( lmin#,lmax# )
	
		lifemin=lmin
		lifemax=lmax
		
	End Function
	
	' Set start scale x/y and min/max random scale of particle
	Function SetScale( sx#,sy#,smin#,smax# )
	
		scalex=sx
		scaley=sy
		scalemin=smin
		scalemax=smax
		
	End Function
	
	' Creates new particles if not already created
	Function UpdateParticles:TParticle( inst:Byte Ptr,life:Int )
	
		Local inlist%=0, part:TParticle
		part=TParticle(TEntity.GetObject(inst))
		If part<>Null
			If inst=TSprite.GetInstance(part) Then inlist=True
		EndIf
		
		If inlist=False ' create new particle
			part=TParticle.CreateObject(inst)
			ListAddLast part_list,part
			
			' set initial data
			part.lifeend=lifemax
			part.liferand=Rand(lifemin,lifemax)
			part.scalerand=Rnd(scalemin,scalemax)
			numparticles:+1
		EndIf
		
		If part<>Null
			part.instance=inst
			part.life=life
		EndIf
		Return part
		
	End Function
	
	' Callback function called in UpdateWorld (inst is instance of entity, life is lifespan left)
	Function Callback( inst:Byte Ptr,life:Int )
	
		Local part:TParticle=UpdateParticles(inst,life)
		
		' end of particle life
		If (lifemax - part.life) > part.liferand
			HideEntity part
		EndIf
		
		' particle alpha
		Local partalpha#=Float(part.life) / (part.lifeend+1) ' normalized to 0..1 (+1 so never divide by 0)
		EntityAlpha part,partalpha/3
		
		' particle scale
		Local partscale#=Float(part.liferand - part.life) / (part.lifeend+1) ' normalized - 1..0
		Local sx#=(scalex + partscale) * part.scalerand
		Local sy#=(scaley + partscale) * part.scalerand
		ScaleSprite part,sx,sy
		
		'DebugLog "partalpha="+partalpha+" life="+part.life+" max="+part.lifeend
		'DebugLog "partscale="+partscale+" sx="+sx+" life="+part.life
		
	End Function
	
	' Frees particle emitter and all of its particles
	Function FreeParticles( emit:TParticleEmitter )
	
		TParticle.ent_map.Clear() ' no ClearMap in PtrMap
		FreeEntity emit
		
		For Local part:TSprite=EachIn part_list
			If part.exists
				part.FreeEntityList() ' can't use FreeEntity on sprites
				part.exists=0
			EndIf
		Next
		
	End Function
	
End Type
