// https://www.syntaxbomb.com/index.php/topic,3864.0.html

uniform mat4 _Object2World;

varying vec2 texCoords;
varying vec3 eye;
varying vec4 wpos;
varying vec3 normal;
varying vec3 vcol;

void main()
{	
	texCoords = gl_MultiTexCoord0.st;
	wpos = _Object2World * gl_Vertex;
	normal = gl_Normal;
	vcol = gl_Color;
	gl_Position = ftransform();
}
