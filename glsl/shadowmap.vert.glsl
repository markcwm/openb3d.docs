// https://sourceforge.net/projects/minib3d/files/OB3DPlus%200.1%20src.tar.gz/download

varying vec4 shadowCoordinate;
varying vec3 normal;
varying vec4 vpos, lightPos;
 
uniform mat4 lightingInvMatrix;
uniform mat4 modelMat;
uniform mat4 projMatrix;

uniform mat4 biasMatrix;
 
// Inverse matrix by G-Truc Creation (www.g-truc.net)
mat4 inversemat4(mat4 m)
{
   float SubFactor00 = m[2][2] * m[3][3] - m[3][2] * m[2][3];
   float SubFactor01 = m[2][1] * m[3][3] - m[3][1] * m[2][3];
   float SubFactor02 = m[2][1] * m[3][2] - m[3][1] * m[2][2];
   float SubFactor03 = m[2][0] * m[3][3] - m[3][0] * m[2][3];
   float SubFactor04 = m[2][0] * m[3][2] - m[3][0] * m[2][2];
   float SubFactor05 = m[2][0] * m[3][1] - m[3][0] * m[2][1];
   float SubFactor06 = m[1][2] * m[3][3] - m[3][2] * m[1][3];
   float SubFactor07 = m[1][1] * m[3][3] - m[3][1] * m[1][3];
   float SubFactor08 = m[1][1] * m[3][2] - m[3][1] * m[1][2];
   float SubFactor09 = m[1][0] * m[3][3] - m[3][0] * m[1][3];
   float SubFactor10 = m[1][0] * m[3][2] - m[3][0] * m[1][2];
   float SubFactor11 = m[1][1] * m[3][3] - m[3][1] * m[1][3];
   float SubFactor12 = m[1][0] * m[3][1] - m[3][0] * m[1][1];
   float SubFactor13 = m[1][2] * m[2][3] - m[2][2] * m[1][3];
   float SubFactor14 = m[1][1] * m[2][3] - m[2][1] * m[1][3];
   float SubFactor15 = m[1][1] * m[2][2] - m[2][1] * m[1][2];
   float SubFactor16 = m[1][0] * m[2][3] - m[2][0] * m[1][3];
   float SubFactor17 = m[1][0] * m[2][2] - m[2][0] * m[1][2];
   float SubFactor18 = m[1][0] * m[2][1] - m[2][0] * m[1][1];
   mat4 adj;
   
   adj[0][0] = + (m[1][1] * SubFactor00 - m[1][2] * SubFactor01 + m[1][3] * SubFactor02);
   adj[1][0] = - (m[1][0] * SubFactor00 - m[1][2] * SubFactor03 + m[1][3] * SubFactor04);
   adj[2][0] = + (m[1][0] * SubFactor01 - m[1][1] * SubFactor03 + m[1][3] * SubFactor05);
   adj[3][0] = - (m[1][0] * SubFactor02 - m[1][1] * SubFactor04 + m[1][2] * SubFactor05);
   adj[0][1] = - (m[0][1] * SubFactor00 - m[0][2] * SubFactor01 + m[0][3] * SubFactor02);
   adj[1][1] = + (m[0][0] * SubFactor00 - m[0][2] * SubFactor03 + m[0][3] * SubFactor04);
   adj[2][1] = - (m[0][0] * SubFactor01 - m[0][1] * SubFactor03 + m[0][3] * SubFactor05);
   adj[3][1] = + (m[0][0] * SubFactor02 - m[0][1] * SubFactor04 + m[0][2] * SubFactor05);
   adj[0][2] = + (m[0][1] * SubFactor06 - m[0][2] * SubFactor07 + m[0][3] * SubFactor08);
   adj[1][2] = - (m[0][0] * SubFactor06 - m[0][2] * SubFactor09 + m[0][3] * SubFactor10);
   adj[2][2] = + (m[0][0] * SubFactor11 - m[0][1] * SubFactor09 + m[0][3] * SubFactor12);
   adj[3][2] = - (m[0][0] * SubFactor08 - m[0][1] * SubFactor10 + m[0][2] * SubFactor12);
   adj[0][3] = - (m[0][1] * SubFactor13 - m[0][2] * SubFactor14 + m[0][3] * SubFactor15);
   adj[1][3] = + (m[0][0] * SubFactor13 - m[0][2] * SubFactor16 + m[0][3] * SubFactor17);
   adj[2][3] = - (m[0][0] * SubFactor14 - m[0][1] * SubFactor16 + m[0][3] * SubFactor18);
   adj[3][3] = + (m[0][0] * SubFactor15 - m[0][1] * SubFactor17 + m[0][2] * SubFactor18);
   
   float det = (+ m[0][0] * adj[0][0]
		+ m[0][1] * adj[1][0]
		+ m[0][2] * adj[2][0]
		+ m[0][3] * adj[3][0]);
   return adj / det;
}

// Get inverse matrix ported from OpenB3D
mat4 getinversemat4(mat4 m)
{
	float tx=0.0;
	float ty=0.0;
	float tz=0.0;
	mat4 mat;
	
	// the rotational part of the matrix is simply the transpose of the original matrix.
	mat[0][0] = m[0][0];
	mat[1][0] = m[0][1];
	mat[2][0] = m[0][2];

	mat[0][1] = m[1][0];
	mat[1][1] = m[1][1];
	mat[2][1] = m[1][2];

	mat[0][2] = m[2][0];
	mat[1][2] = m[2][1];
	mat[2][2] = m[2][2];

	// The right column vector of the matrix should always be [ 0 0 0 1 ]
	// in most cases. . . you don't need this column at all because it'll
	// never be used in the program, but since this code is used with GL
	// and it does consider this column, it is here.
	mat[0][3] = 0.0;
	mat[1][3] = 0.0;
	mat[2][3] = 0.0;
	mat[3][3] = 1.0;

	// The translation components of the original matrix.
	tx = m[3][0];
	ty = m[3][1];
	tz = m[3][2];

	// result = -(Tm * Rm) To get the translation part of the inverse
	mat[3][0] = -( (m[0][0] * tx) + (m[0][1] * ty) + (m[0][2] * tz) );
	mat[3][1] = -( (m[1][0] * tx) + (m[1][1] * ty) + (m[1][2] * tz) );
	mat[3][2] = -( (m[2][0] * tx) + (m[2][1] * ty) + (m[2][2] * tz) );
	
	return mat;
}

void main() {
	shadowCoordinate = biasMatrix*projMatrix*lightingInvMatrix*modelMat* gl_Vertex;
	normal = normalize(gl_NormalMatrix * gl_Normal);
	vpos = gl_ModelViewMatrix * gl_Vertex;
	
	// lightPos=inverse(lightingInvMatrix)[3]; // GLSL
	// inverse function is not properly supported on Mac, so replaced with either functions below, all work
	//lightPos=inversemat4(lightingInvMatrix)[3]; // G-Truc inverse
	lightPos=getinversemat4(lightingInvMatrix)[3]; // BRL inverse

	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}

