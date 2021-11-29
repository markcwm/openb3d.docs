' particletypes.bmx

' SIMPLE TEST PARTICLES
Function CreateEmitter_Test:TParticleCandyEmitter( pc:TParticleCandy )

	Local EM:TParticleCandyEmitter, P1:Int
	EM = pc.createEmitter()

	P1 = pc.createParticleType()
	pc.setPTImage( P1, 8 )
	pc.setPTSpeed( P1, 7 )
	pc.setPTSize( P1, 0.25 )
	pc.setPTAlpha( P1, 1 )
	pc.setPTWeight( P1, 0.5 )
	pc.setPTRotation( P1, 0, 0 )
	pc.setPTColor( P1, 240, 240, 240, 40, -50, -50, -50 )
	pc.setPTEmissionAngle( P1, 0, 90 )
	pc.setPTStartOffsets( P1, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P1, 4000 )
	pc.setPTBounce( P1, 0, 0, 0 )
	pc.setPTAddedBlend( P1, 0 )

	EM.addParticleType( P1 , 0 , 99000 , 985 )
	
	If TParticleCandy.DEBUG = True Then DebugLog "creating emitter..."
	Return EM
End Function


' ROCKS
Function CreateEmitter_Rocks:TParticleCandyEmitter( pc:TParticleCandy )

	Local EM:TParticleCandyEmitter, P1:Int, P2:Int
	EM = pc.createEmitter()

	P1 = pc.createParticleType()
	pc.setPTImage( P1, 8 )
	pc.setPTSpeed( P1, 20, 5 )
	pc.setPTSize( P1, 0.6, 0.5 )
	pc.setPTAlpha( P1, 1, 0, 0 )
	pc.setPTWeight( P1, 8, 5 )
	pc.setPTRotation( P1, 1, 400 )
	pc.setPTColor( P1, 240, 240, 240, 40, 0, 0, 0 )
	pc.setPTEmissionAngle( P1, 3, 130 )
	pc.setPTStartOffsets( P1, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P1, 3000 )
	pc.setPTBounce( P1, -7, 0.5, 16 )
	pc.setPTPulsation( P1, 0 )
	pc.setPTAddedBlend( P1, 0 )
	
	' SMOKE
	P2 = pc.createParticleType()
	pc.setPTImage( P2, 5 )
	pc.setPTSpeed( P2, 4, 2 )
	pc.setPTSize( P2, 1, 1, 5 )
	pc.setPTAlpha( P2, 0.5, 0.3, -1 )
	pc.setPTWeight( P2, -0.5, 0.1 )
	pc.setPTRotation( P2, 1, 45 )
	pc.setPTColor( P2, 125, 125, 130, 20, -15, -15, -25 )
	pc.setPTEmissionAngle( P2, 3, 180 )
	pc.setPTStartOffsets( P2, -3, 6, -2, 8, -3, 6 )
	pc.setPTLifeTime( P2, 1000 )
	pc.setPTBounce( P2, -5, 1, 10 )
	pc.setPTPulsation( P2, 0 )
	pc.setPTAddedBlend( P2, 0 )

	'TODO Emitter_SetSound EM,soundPath$+"bang.mp3",0
	EM.addParticleType( P1, 0, 50, 400 )
	EM.addParticleType( P2, 0, 50, 200 )

	Return EM
End Function

' EXPLOSION 1
Function CreateEmitter_Explosion1:TParticleCandyEmitter( pc:TParticleCandy )

	Local EM:TParticleCandyEmitter, P1:Int, P2:Int, P3:Int, P4:Int, P5:Int
	EM = pc.createEmitter()

	' SHORT FLASH
	P1 = pc.createParticleType()
	pc.setPTImage( P1, 5 )
	pc.setPTSpeed( P1, 0, 0 )
	pc.setPTSize( P1, 2, 0, -2 )
	pc.setPTAlpha( P1, 1, 0, 0 )
	pc.setPTWeight( P1, 0, 0 )
	pc.setPTRotation( P1, 1, 0 )
	pc.setPTColor( P1, 255, 255, 200, 0, -200, -200, -200 )
	pc.setPTEmissionAngle( P1, 0, 1 )
	pc.setPTStartOffsets( P1, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P1, 500 )
	pc.setPTBounce( P1, 0, 0, 0 )
	pc.setPTPulsation( P1, 4 )
	pc.setPTAddedBlend( P1, 1 )
	
	' RED CLOUDS
	P2 = pc.createParticleType()
	pc.setPTImage( P2, 5 )
	pc.setPTSpeed( P2, 0, 0 )
	pc.setPTSize( P2, 1, 0.5, 15, 5 )
	pc.setPTAlpha( P2, 1, 0.25, -0.18 )
	pc.setPTWeight( P2, 0, 0 )
	pc.setPTRotation( P2, 1, 0 )
	pc.setPTColor( P2, 255, 246, 149, 0, -150, -200, -200 )
	pc.setPTEmissionAngle( P2, 0, 360 )
	pc.setPTStartOffsets( P2, -3, 6, -3, 6, -3, 6 )
	pc.setPTLifeTime( P2, 2000 )
	pc.setPTBounce( P2, 0, 0, 0 )
	pc.setPTPulsation( P2, 0 )
	pc.setPTAddedBlend( P2, 1 )
	
	' SMALL PARTICLES
	P3 = pc.createParticleType()
	pc.setPTImage( P3, 6 )
	pc.setPTSpeed( P3, 10, 1 )
	pc.setPTSize( P3, 3, 0.5, -1 )
	pc.setPTAlpha( P3, 1, 0.25, -0.8 )
	pc.setPTWeight( P3, 0, 0 )
	pc.setPTRotation( P3, 1, 0 )
	pc.setPTColor( P3, 255, 246, 149, 0, 0, 0, 0 )
	pc.setPTEmissionAngle( P3, 0, 360 )
	pc.setPTStartOffsets( P3, -1, 2, -1, 2, -1, 2 )
	pc.setPTLifeTime( P3, 2000 )
	pc.setPTBounce( P3, 0, 0, 0 )
	pc.setPTPulsation( P3, 0 )
	pc.setPTAddedBlend( P3, 1 )
	
	' SMOKE
	P4 = pc.createParticleType()
	pc.setPTImage( P4, 5 )
	pc.setPTSpeed( P4, 2, 0.5 )
	pc.setPTSize( P4, 1, 0.5, 15, 4 )
	pc.setPTAlpha( P4, 1, 0.25, -0.15 )
	pc.setPTWeight( P4, 0, 0 )
	pc.setPTRotation( P4, 1, 0 )
	pc.setPTColor( P4, 70, 70, 70, 20, -30, -30, -30 )
	pc.setPTEmissionAngle( P4, 0, 360 )
	pc.setPTStartOffsets( P4, -4, 8, -4, 8, -4, 8 )
	pc.setPTLifeTime( P4, 3000 )
	pc.setPTBounce( P4, 0, 0, 0 )
	pc.setPTPulsation( P4, 0 )
	pc.setPTAddedBlend( P4, 1 )
	
	' SPARKS
	P5 = pc.createParticleType()
	pc.setPTImage( P5, 1 )
	pc.setPTSpeed( P5, 15, 5 )
	pc.setPTSize( P5, 0.5, 0.15, -0.5 )
	pc.setPTAlpha( P5, 1, 0.25, -0.18 )
	pc.setPTWeight( P5, 2, 0 )
	pc.setPTRotation( P5, 2, 0 )
	pc.setPTColor( P5, 255, 246, 149, 20, -150, -200, -150 )
	pc.setPTEmissionAngle( P5, 0, 360 )
	pc.setPTStartOffsets( P5, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P5, 2000 )
	pc.setPTBounce( P5, 0, 0, 0 )
	pc.setPTPulsation( P5, 0 )
	pc.setPTAddedBlend( P5, 1 )

	'TODO Emitter_SetSound EM,soundPath$+"explosion.mp3",0
	EM.addParticleType( P1, 0, 110, 10 )
	EM.addParticleType( P2, 100, 150, 50 )
	EM.addParticleType( P3, 150, 200, 125 )
	EM.addParticleType( P4, 250, 350, 40 )
	EM.addParticleType( P5, 100, 400, 150 )

	Return EM	
End Function

' EXPLOSION 2
Function CreateEmitter_Explosion2:TParticleCandyEmitter( pc:TParticleCandy )

	Local EM:TParticleCandyEmitter, P1:Int, P2:Int, P3:Int, P4:Int, P5:Int, P6:Int, P7:Int
	EM = pc.createEmitter()

	' SHORT FLASH
	P1 = pc.createParticleType()
	pc.setPTImage( P1, 5 )
	pc.setPTSpeed( P1, 0, 0 )
	pc.setPTSize( P1, 2, 0, -2 )
	pc.setPTAlpha( P1, 1, 0, 0 )
	pc.setPTWeight( P1, 0, 0 )
	pc.setPTRotation( P1, 1, 0 )
	pc.setPTColor( P1, 255, 255, 200, 0, -200, -200, -200 )
	pc.setPTEmissionAngle( P1, 0, 1 )
	pc.setPTStartOffsets( P1, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P1, 500 )
	pc.setPTBounce( P1, 0, 0, 0 )
	pc.setPTPulsation( P1, 4 )
	pc.setPTAddedBlend( P1, 1 )
	
	' RED CLOUDS
	P2 = pc.createParticleType()
	pc.setPTImage( P2, 5 )
	pc.setPTSpeed( P2, 0, 0 )
	pc.setPTSize( P2, 1, 0.5, 15, 5 )
	pc.setPTAlpha( P2, 1, 0.25, -0.18 )
	pc.setPTWeight( P2, 0, 0 )
	pc.setPTRotation( P2, 1, 0 )
	pc.setPTColor( P2, 255, 246, 149, 0, -150, -200, -200 )
	pc.setPTEmissionAngle( P2, 0, 360 )
	pc.setPTStartOffsets( P2, -3, 6, -3, 6, -3, 6 )
	pc.setPTLifeTime( P2, 2000 )
	pc.setPTBounce( P2, 0, 0, 0 )
	pc.setPTPulsation( P2, 0 )
	pc.setPTAddedBlend( P2, 1 )
	
	' SPARKS
	P3 = pc.createParticleType()
	pc.setPTImage( P3, 1 )
	pc.setPTSpeed( P3, 20, 5 )
	pc.setPTSize( P3, 0.5, 0.5, -1 )
	pc.setPTAlpha( P3, 1, 0.25, -0.8 )
	pc.setPTWeight( P3, 0, 0 )
	pc.setPTRotation( P3, 2, 0 )
	pc.setPTColor( P3, 255, 246, 149, 50, -200, -300, -300 )
	pc.setPTEmissionAngle( P3, 0, 360 )
	pc.setPTStartOffsets( P3, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P3, 2000 )
	pc.setPTBounce( P3, 0, 0, 0 )
	pc.setPTPulsation( P3, 0 )
	pc.setPTAddedBlend( P3, 1 )
	
	' SMOKE
	P4 = pc.createParticleType()
	pc.setPTImage( P4, 5 )
	pc.setPTSpeed( P4, 2, 0.5 )
	pc.setPTSize( P4, 1, 0.5, 15, 4 )
	pc.setPTAlpha( P4, 1, 0.25, -0.15 )
	pc.setPTWeight( P4, 0, 0 )
	pc.setPTRotation( P4, 1, 0 )
	pc.setPTColor( P4, 70, 70, 70, 20, -30, -30, -30 )
	pc.setPTEmissionAngle( P4, 0, 360 )
	pc.setPTStartOffsets( P4, -4, 8, -4, 8, -4, 8 )
	pc.setPTLifeTime( P4, 3000 )
	pc.setPTBounce( P4, 0, 0, 0 )
	pc.setPTPulsation( P4, 0 )
	pc.setPTAddedBlend( P4, 1 )
	
	' DEBRIS SMOKE TRAIL
	P5 = pc.createParticleType()
	pc.setPTImage( P5, 9 )
	pc.setPTSpeed( P5, 4, 2 )
	pc.setPTSize( P5, 0.5, 0.5, 3, 1 )
	pc.setPTAlpha( P5, 0.25, 0.25, -0.45 )
	pc.setPTWeight( P5, 0, 0.1 )
	pc.setPTRotation( P5, 1, 45 )
	pc.setPTColor( P5, 125, 125, 135, 20, -15, -15, -25 )
	pc.setPTEmissionAngle( P5, 3, 180 )
	pc.setPTStartOffsets( P5, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P5, 3000 )
	pc.setPTBounce( P5, 0, 0, 0 )
	pc.setPTPulsation( P5, 0 )
	pc.setPTAddedBlend( P5, 0 )
	
	' DEBRIS
	P6 = pc.createParticleType()
	pc.setPTImage( P6, 7 )
	pc.setPTSpeed( P6, 15, 5 )
	pc.setPTSize( P6, 1, 0.5, -1 )
	pc.setPTAlpha( P6, 1, 0.25, -0.15 )
	pc.setPTWeight( P6, 1, 0 )
	pc.setPTRotation( P6, 0, 0 )
	pc.setPTColor( P6, 255, 246, 149, 20, -150, -200, -150 )
	pc.setPTEmissionAngle( P6, 3, 360 )
	pc.setPTStartOffsets( P6, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P6, 2000 )
	pc.setPTBounce( P6, 0, 0, 0 )
	pc.setPTPulsation( P6, 0 )
	pc.setPTAddedBlend( P6, 1 )
	pc.setPTTrail( P6, P5, 0, 1000, 45 )
	
	' SPARKLES
	P7 = pc.createParticleType()
	pc.setPTImage( P7, 7 )
	pc.setPTSpeed( P7, 1, 0.5)
	pc.setPTRandomSpeed( P7, 0.05, 0.05, 0.05 )
	pc.setPTSize( P7, 0.5, 0.5, -0.5 )
	pc.setPTAlpha( P7, 1, 0.25, -0.15 )
	pc.setPTWeight( P7, 1, 0 )
	pc.setPTRotation( P7, 0, 0 )
	pc.setPTColor( P7, 255, 246, 149, 20, -150, -200, -150 )
	pc.setPTEmissionAngle( P7, 3, 360 )
	pc.setPTStartOffsets( P7, 0, 0, 0, 0, 0, 0 )
	pc.setPTLifeTime( P7, 2000 )
	pc.setPTBounce( P7, 0, 0, 0 )
	pc.setPTPulsation( P7, 0 )
	pc.setPTAddedBlend( P7, 1 )

	'TODO Emitter_SetSound EM,soundPath$+"explosion.mp3",0
	EM.addParticleType( P1, 0, 110, 10 )
	EM.addParticleType( P2, 100, 150, 50 )
	EM.addParticleType( P3, 200, 250, 150 )
	EM.addParticleType( P4, 250, 350, 40 )
	EM.addParticleType( P6, 100, 300, 125 )
	EM.addParticleType( P7, 400, 600, 150 )

	Return EM	
End Function
