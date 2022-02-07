// https://sourceforge.net/projects/minib3d/files/OB3DPlus%200.1%20src.tar.gz/download

#version 140

varying vec4 shadowCoordinate;
varying vec3 normal;
varying vec4 vpos, lightPos;
 
uniform mat4 lightingInvMatrix;
uniform mat4 modelMat;
uniform mat4 projMatrix;

uniform mat4 biasMatrix;

 
void main() {
	shadowCoordinate = biasMatrix*projMatrix*lightingInvMatrix *modelMat* gl_Vertex;
	normal = normalize(gl_NormalMatrix * gl_Normal);
	vpos = gl_ModelViewMatrix * gl_Vertex;
	lightPos=inverse(lightingInvMatrix)[3];

	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
};
