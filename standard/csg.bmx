' csg.bmx
' constructive solid geometry

Strict

Framework Openb3d.B3dglgraphics

Graphics3D DesktopWidth(),DesktopHeight(),0,2

Local cam:TCamera=CreateCamera()
MoveEntity cam,0,0,-5
CameraClsColor cam,70,180,235

Local light:TLight=CreateLight(1)
LightColor light,100,100,150

Local cube:TMesh=CreateCylinder(32)
PositionEntity cube,0.75,-0.75,0.75

Local cube2:TMesh=CreateCylinder(32)
HideEntity cube
HideEntity cube2

Local csg:TMesh=MeshCSG(cube,cube2,0)
Local csg2:TMesh=MeshCSG(cube,cube2,1)
Local csg3:TMesh=MeshCSG(cube,cube2,2)
HideEntity csg2
HideEntity csg3

Local meshmethod%, meshflip%


While Not KeyDown(KEY_ESCAPE)

	' change csg method
	If KeyHit(KEY_M)
		meshmethod:+1
		If meshmethod>2 Then meshmethod=0
		If meshmethod=0 Then HideEntity csg3 ; ShowEntity csg
		If meshmethod=1 Then HideEntity csg ; ShowEntity csg2
		If meshmethod=2 Then HideEntity csg2 ; ShowEntity csg3	
	EndIf
	
	If KeyHit(Key_W)
	Weld(csg)
	EndIf
	
	If KeyHit(KEY_F)
		meshflip=Not meshflip
		FlipMesh csg
		FlipMesh csg2
		FlipMesh csg3
	EndIf
	
	TurnEntity csg,0,0.5,-0.1
	TurnEntity csg2,0,0.5,-0.1
	TurnEntity csg3,0,0.5,-0.1
	
	RenderWorld
	
	Text 0,20,"M: meshmethod = "+meshmethod+", F: meshflip = "+meshflip
	
	Flip

Wend
End

' ID: 454
' Author: TeraBit
' Date: 2002-10-09 10:11:10
' Title: Weld()
' Description: Weld a mesh's vertices




Type Tris
	Global tvq:TList=CreateList()
	
	Field x0#
	Field y0#
	Field z0#
	
	Field r0
	Field g0
	Field b0
	Field alpha0#

	Field u0#
	Field v0#
	Field U20#
	Field V20#
	
	Field x1#
	Field y1#
	Field z1#
	
	Field r1
	Field g1
	Field b1
	Field alpha1#

	Field u1#
	Field v1#
	Field U21#
	Field V21#
	
	Field x2#
	Field y2#
	Field z2#
	
	Field r2
	Field g2
	Field b2
	Field alpha2#

	Field u2#
	Field v2#

	Field U22#
	Field V22#
	
	Field surface
End Type


Function Weld(mish:TMesh)
Local txv:Int[3]
For Local nsurf% = 1 To CountSurfaces(mish)
Local su:TSurface=GetSurface(mish,nsurf)
For Local tq% = 0 To CountTriangles(su)-1
	txv[0] = TriangleVertex(su,tq,0)
	txv[1] = TriangleVertex(su,tq,1)
	txv[2] = TriangleVertex(su,tq,2)
	'DebugLog txv[0]+" "+txv[1]+" "+txv[2]
	Local vq:Tris = New Tris
	vq.x0# = VertexX(su,txv[0])
	vq.y0# = VertexY(su,txv[0])
	vq.z0# = VertexZ(su,txv[0])
	vq.u0# = VertexU(su,txv[0],0)
	vq.v0# = VertexV(su,txv[0],0)
	vq.u20# = VertexU(su,txv[0],1)
	vq.v20# = VertexV(su,txv[0],1)
	
	vq.r0	= VertexRed(su,txv[0])
	vq.g0 	= VertexGreen(su,txv[0])
	vq.b0	= VertexBlue(su,txv[0])
	vq.alpha0# = VertexAlpha(su,txv[0])
	
	
	vq.x1# = VertexX(su,txv[1])
	vq.y1# = VertexY(su,txv[1])
	vq.z1# = VertexZ(su,txv[1])
	vq.u1# = VertexU(su,txv[1],0)
	vq.v1# = VertexV(su,txv[1],0)
	vq.u21# = VertexU(su,txv[1],1)
	vq.v21# = VertexV(su,txv[1],1)
	
	vq.r1	= VertexRed(su,txv[1])
	vq.g1 	= VertexGreen(su,txv[1])
	vq.b1	= VertexBlue(su,txv[1])
	vq.alpha1# = VertexAlpha(su,txv[1])

	vq.x2# = VertexX(su,txv[2])
	vq.y2# = VertexY(su,txv[2])
	vq.z2# = VertexZ(su,txv[2])
	vq.u2# = VertexU(su,txv[2],0)
	vq.v2# = VertexV(su,txv[2],0)
	vq.u22# = VertexU(su,txv[2],1)
	vq.v22# = VertexV(su,txv[2],1)
	
	vq.r2	= VertexRed(su,txv[2])
	vq.g2 	= VertexGreen(su,txv[2])
	vq.b2	= VertexBlue(su,txv[2])
	vq.alpha2# = VertexAlpha(su,txv[2])
	ListAddLast Tris.tvq,vq
Next

ClearSurface su
Local mycount%=0
Local width%=1

For Local vq:Tris = EachIn Tris.tvq

		Local vt1%=Findvert(su,vq.x0#,vq.y0#,vq.z0#,vq.u0#,vq.v0#,vq.u20#,vq.v20#)
		
		If vt1=0 Then
			AddVertex su,vq.x0#,vq.y0#,vq.z0#,vq.u0#,vq.v0#
		'	VertexTexCoords su,mycount,vq.u20#,vq.v20#,0,0
			VertexTexCoords su,mycount,(vq.x0#/4)/32,(vq.z0#/4)/32,0,1
			VertexColor su,mycount,vq.r0,vq.g0,vq.b0,vq.alpha0 
			vt1 = mycount
			mycount = mycount +1
		EndIf

		Local vt2%=Findvert(su,vq.x1#,vq.y1#,vq.z1#,vq.u1#,vq.v1#,vq.u21#,vq.v21#)
		
		If vt2=0 Then
			AddVertex su,vq.x1#,vq.y1#,vq.z1#,vq.u1#,vq.v1#
		'	VertexTexCoords su,mycount,vq.u21#,vq.v21#,0,0
			VertexTexCoords su,mycount,(vq.x1#/4)/32,(vq.z1#/4)/32,0,1
			VertexColor su,mycount,vq.r1,vq.g1,vq.b1,vq.alpha1 
			vt2 = mycount
			mycount = mycount +1
		EndIf
		
		Local vt3%=Findvert(su,vq.x2#,vq.y2#,vq.z2#,vq.u2#,vq.v2#,vq.u22#,vq.v22#)
		
		If vt3=0 Then 
			AddVertex su,vq.x2#,vq.y2#,vq.z2#,vq.u2#,vq.v2#
		'	VertexTexCoords su,mycount,vq.u22#,vq.v22#,0,0
			VertexTexCoords su,mycount,(vq.x2#/4.0)/Float(width),(vq.z2#/4.0)/Float(width),0,1
			VertexColor su,mycount,vq.r2,vq.g2,vq.b2,vq.alpha2 
			vt3 = mycount
			mycount = mycount +1
		EndIf

	AddTriangle su,vt1,vt2,vt3
Next

For Local vq:Tris = EachIn Tris.tvq
	ListRemove( Tris.tvq,vq )
Next
mycount=0
Next
End Function

Function Findvert:Int(su:TSurface,x2#,y2#,z2#,u2#,v2#,u22#,v22#)
For Local t%=0 To CountVertices(su)-1
	If VertexX(su,t)=x2# Then 
		If VertexY(su,t)=y2# Then 
			If VertexZ(su,t)=z2# Then 
				If VertexU(su,t,0)=u2# Then 
					If VertexV(su,t,0)=v2# Then 
					'	If VertexU(su,t,1)=u22# Then 
					'		If VertexV(su,t,1)=v22# Then
								Return t
					'		EndIf
					'	EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
Next
Return 0
End Function

