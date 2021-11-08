' TMatrix_test.bmx
' how to convert from TMatrix to TMatPtr and back

Strict

Framework Openb3d.B3dglgraphics

Local mat:TMatrix=New TMatrix
mat.LoadIdentity()
mat.grid[0,0]=1.0
mat.grid[0,1]=2.0
mat.grid[0,2]=3.0

Local pmat:TMatPtr=TMatPtr.Create()
pmat.LoadIdentity()
pmat.grid[(4*0)+0]=4.0
pmat.grid[(4*0)+1]=5.0
pmat.grid[(4*0)+2]=6.0

DebugLog "Start values"
DebugLog "mat.00="+mat.grid[0,0]+" mat.01="+mat.grid[0,1]+" mat.02="+mat.grid[0,2]
DebugLog "pmat.00="+pmat.grid[(4*0)+0]+" pmat.01="+pmat.grid[(4*0)+1]+" pmat.02="+pmat.grid[(4*0)+2]
DebugLog ""

Local mat2:TMatrix=TMatrix.CopyMatPtr(pmat)
Local pmat2:TMatPtr=TMatPtr.CopyMatrix(mat)

DebugLog "Copy values"
DebugLog "mat2.00="+mat2.grid[0,0]+" mat2.01="+mat2.grid[0,1]+" mat2.02="+mat2.grid[0,2]
DebugLog "pmat2.00="+pmat2.grid[(4*0)+0]+" pmat2.01="+pmat2.grid[(4*0)+1]+" pmat2.02="+pmat2.grid[(4*0)+2]
DebugLog ""

mat.Multiply(mat2)
pmat.Multiply(pmat2)

DebugLog "Multiply values"
DebugLog "mat.00="+mat.grid[0,0]+" mat.01="+mat.grid[0,1]+" mat.02="+mat.grid[0,2]
DebugLog "pmat.00="+pmat.grid[(4*0)+0]+" pmat.01="+pmat.grid[(4*0)+1]+" pmat.02="+pmat.grid[(4*0)+2]
DebugLog ""

mat.GetMatPtr(pmat2)
pmat.GetMatrix(mat2)

DebugLog "Get start values"
DebugLog "mat.00="+mat.grid[0,0]+" mat.01="+mat.grid[0,1]+" mat.02="+mat.grid[0,2]
DebugLog "pmat.00="+pmat.grid[(4*0)+0]+" pmat.01="+pmat.grid[(4*0)+1]+" pmat.02="+pmat.grid[(4*0)+2]
DebugLog ""
