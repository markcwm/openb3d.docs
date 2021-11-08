' TVector_test.bmx
' how to convert from TVector to TVecPtr and back

Strict

Framework Openb3d.B3dglgraphics

Local vec:TVector=New TVector
vec.x=1.0
vec.y=2.0
vec.z=3.0

Local pvec:TVecPtr=TVecPtr.Create( 4.0,5.0,6.0 )

DebugLog "Start values"
DebugLog "vec.x="+vec.x+" vec.y="+vec.y+" vec.z="+vec.z
DebugLog "pvec.x="+pvec.x[0]+" pvec.y="+pvec.y[0]+" pvec.z="+pvec.z[0]
DebugLog ""

Local vec2:TVector=TVector.CopyVecPtr(pvec)
Local pvec2:TVecPtr=TVecPtr.CopyVector(vec)

DebugLog "Copy values"
DebugLog "vec2.x="+vec2.x+" vec2.y="+vec2.y+" vec2.z="+vec2.z
DebugLog "pvec2.x="+pvec2.x[0]+" pvec2.y="+pvec2.y[0]+" pvec2.z="+pvec2.z[0]
DebugLog ""

Local vec3:TVector=vec.Add(vec2)
Local pvec3:TVecPtr=pvec.Add(pvec2)

DebugLog "Add values"
DebugLog "vec3.x="+vec3.x+" vec3.y="+vec3.y+" vec3.z="+vec3.z
DebugLog "pvec3.x="+pvec3.x[0]+" pvec3.y="+pvec3.y[0]+" pvec3.z="+pvec3.z[0]
DebugLog ""

vec3.GetVecPtr(pvec2)
pvec3.GetVector(vec2)

DebugLog "Get start values"
DebugLog "vec3.x="+vec3.x+" vec3.y="+vec3.y+" vec3.z="+vec3.z
DebugLog "pvec3.x="+pvec3.x[0]+" pvec3.y="+pvec3.y[0]+" pvec3.z="+pvec3.z[0]
DebugLog ""
