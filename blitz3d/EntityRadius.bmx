' EntityRadius.bmx

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight()

Local camera:TCamera=CreateCamera()
Local light:TLight=CreateLight()

Local sphere:TMesh=CreateSphere( 32 )
PositionEntity sphere,-2,0,5

' Set collision type values
Local type_sphere%=1
Local type_cone%=2

Local cone:TMesh=CreateCone( 32 )
EntityType cone,type_cone
PositionEntity cone,2,0,5

' Set sphere radius value
Local sphere_radius#=1

' Set sphere and cone entity types
EntityType sphere,type_sphere
EntityType cone,type_cone

' Enable collisions between type_sphere and type_cone, with ellipsoid->polygon method and slide response
Collisions type_sphere,type_cone,2,2

While Not KeyDown( KEY_ESCAPE )
	
	Local x#=0
	Local y#=0
	Local z#=0
	
	If KeyDown( KEY_LEFT )=True Then x#=-0.1
	If KeyDown( KEY_RIGHT )=True Then x#=0.1
	If KeyDown( KEY_DOWN )=True Then y#=-0.1
	If KeyDown( KEY_UP )=True Then y#=0.1
	If KeyDown( KEY_Z )=True Then z#=-0.1
	If KeyDown( KEY_A )=True Then z#=0.1
	
	MoveEntity sphere,x#,y#,z#
	
	' If square brackets keys pressed Then change sphere radius value
	If KeyDown( KEY_OPENBRACKET )=True Then sphere_radius#=sphere_radius#-0.1
	If KeyDown( KEY_CLOSEBRACKET )=True Then sphere_radius#=sphere_radius#+0.1
	
	' Set entity radius of sphere
	EntityRadius sphere,sphere_radius#
	
	' Perform collision checking
	UpdateWorld
	RenderWorld
	
	Text 0,20,"Use cursor/A/Z keys to move sphere"
	Text 0,40,"Press [ or ] to change EntityRadius radius_x# value"
	Text 0,60,"EntityRadius sphere,"+sphere_radius
	
	Flip
Wend

End 
