' newton_helpers.bmx

'SuperStrict
'Import Openb3dmax.Newtonb3d
'Import Brl.Random

' TEMP:
'Import "../../../openb3dmax.mod/newtonb3d.mod/newtonb3d.bmx"

Function AddRandomCube:TNewtonCube(world:TNWorld, mass_multiplier:Float, shadow:Int = True)

	Local mesh:TMesh = CreateCube()
	
	Local size:Float = Float(Rnd(0.1, 1.0))
	ScaleMesh mesh, size, size, size
	
	MoveEntity mesh, Float(Rnd(-25.0, 25.0)), Float(Rnd(50.0)), Float(Rnd(-25, 25.0))
	TurnEntity mesh, Float(Rnd(-360.0, 360.0)), Float(Rnd(-360.0, 360.0)), Float(Rnd(-360.0, 360.0))
	
	Local cube:TNewtonCube = CreateNewtonCubeMesh(world, mesh, size * mass_multiplier, shadow)
	
	EntityColor mesh, Float(Rnd(255.0)), Float(Rnd(255.0)), Float(Rnd(255.0))
'	EntityColor cube.mesh, Float(Rnd(255.0)), Float(Rnd(255.0)), Float(Rnd(255.0))
	
	Return cube
	
End Function

Function AddRandomSphere:TNewtonSphere(world:TNWorld, mass_multiplier:Float, shadow:Int = True)

	Local mesh:TMesh = CreateSphere()
	
	Local size:Float = Float(Rnd(0.1, 1.0))
	ScaleMesh mesh, size, size, size ' RADIUS!
	
	MoveEntity mesh, Float(Rnd(-25.0, 25.0)), Float(Rnd(50.0)), Float(Rnd(-25, 25.0))
	
	Local sphere:TNewtonSphere = CreateNewtonSphereMesh(world, mesh, size * mass_multiplier, shadow)
	
	EntityColor mesh, Float(Rnd(255.0)), Float(Rnd(255.0)), Float(Rnd(255.0))
'	EntityColor sphere.mesh, Float(Rnd(255.0)), Float(Rnd(255.0)), Float(Rnd(255.0))
	
	Return sphere
	
End Function
