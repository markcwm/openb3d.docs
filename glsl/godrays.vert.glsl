// https://github.com/chudooder/entanglement/blob/master/shaders

varying vec4 vertColor;
varying vec4 texCoord0;
varying vec4 texCoord1;

void main(){
    gl_Position = gl_ModelViewProjectionMatrix*gl_Vertex;
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    vertColor = gl_Color;
	texCoord0 = gl_TexCoord[0];
	texCoord1 = gl_TextureMatrix[1] * gl_MultiTexCoord1;
}
