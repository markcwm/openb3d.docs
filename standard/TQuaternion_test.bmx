' TQuaternion_test.bmx
' how to convert from TQuaternion to TQuatPtr and back

Strict

Framework Openb3d.B3dglgraphics

Local quat:TQuaternion=New TQuaternion
quat.x=1.0
quat.y=2.0
quat.z=3.0

Local pquat:TQuatPtr=TQuatPtr.Create( 4.0,5.0,6.0 )

DebugLog "Start values"
DebugLog "quat.x="+quat.x+" quat.y="+quat.y+" quat.z="+quat.z
DebugLog "pquat.x="+pquat.x[0]+" pquat.y="+pquat.y[0]+" pquat.z="+pquat.z[0]
DebugLog ""

Local quat2:TQuaternion=TQuaternion.CopyQuatPtr(pquat)
Local pquat2:TQuatPtr=TQuatPtr.CopyQuaternion(quat)

DebugLog "Copy values"
DebugLog "quat2.x="+quat2.x+" quat2.y="+quat2.y+" quat2.z="+quat2.z
DebugLog "pquat2.x="+pquat2.x[0]+" pquat2.y="+pquat2.y[0]+" pquat2.z="+pquat2.z[0]
DebugLog ""

quat.x=quat.x+quat2.x
quat.y=quat.y+quat2.y
quat.z=quat.z+quat2.z
pquat.x[0]=pquat.x[0]+pquat2.x[0]
pquat.y[0]=pquat.y[0]+pquat2.y[0]
pquat.z[0]=pquat.z[0]+pquat2.z[0]

DebugLog "Add values"
DebugLog "quat.x="+quat.x+" quat.y="+quat.y+" quat.z="+quat.z
DebugLog "pquat.x="+pquat.x[0]+" pquat.y="+pquat.y[0]+" pquat.z="+pquat.z[0]
DebugLog ""

quat.GetQuatPtr(pquat2)
pquat.GetQuaternion(quat2)

DebugLog "Get start values"
DebugLog "quat.x="+quat.x+" quat.y="+quat.y+" quat.z="+quat.z
DebugLog "pquat.x="+pquat.x[0]+" pquat.y="+pquat.y[0]+" pquat.z="+pquat.z[0]
DebugLog ""
