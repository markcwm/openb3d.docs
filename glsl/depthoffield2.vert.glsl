// https://www.blitzcoder.org/forum/topic.php?id=211

varying vec4 vertColor;
varying vec2 texCoords;
varying vec4 texCoord1;

void main()
{	
	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
	gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	vertColor = gl_Color;
	texCoords = gl_TexCoord[0].st;
	texCoord1 = gl_TextureMatrix[1] * gl_MultiTexCoord1;
}
