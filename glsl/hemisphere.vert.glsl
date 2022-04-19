// https://en.wikibooks.org/wiki/GLSL_Programming/Unity/Diffuse_Reflection_of_Skylight

// shader properties specified by users
uniform vec4 _DiffuseColor; 
uniform vec4 _UpperHemisphereColor;
uniform vec4 _LowerHemisphereColor;
uniform vec3 _UpVector;

uniform mat4 _Object2World; // model matrix
uniform mat4 _World2Object; // inverse model matrix
 
varying vec4 color; // the hemisphere lighting computed in the vertex shader

void main()
{
	gl_TexCoord[0] = gl_MultiTexCoord0;
	
	mat4 modelMatrix = _Object2World;
	mat4 modelMatrixInverse = _World2Object; // unity_Scale.w is unnecessary because we normalize vectors
	
	vec3 normalDirection = normalize(vec3(vec4(gl_Normal, 0.0) * modelMatrixInverse));
	vec3 upDirection = normalize(_UpVector);
	
	float w = 0.5 * (1.0 + dot(upDirection, normalDirection));
	color = (w * _UpperHemisphereColor + (1.0 - w) * _LowerHemisphereColor) * _DiffuseColor;

	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
