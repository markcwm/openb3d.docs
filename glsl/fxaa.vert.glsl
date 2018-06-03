
varying vec4 vertColor;
varying vec2 screenpos;
varying vec4 vertTexcoord;

void main(){
    gl_Position = gl_ModelViewProjectionMatrix*gl_Vertex;
    //gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    vertTexcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    screenpos = gl_MultiTexCoord0.xy;

    vertColor = gl_Color;
}