// https://www.freebasic.net/forum/viewtopic.php?f=14&t=15409&start=870

varying vec3 Position;
varying vec3 Normal;
varying vec2 TexCoord;


void main()
{
   TexCoord = gl_MultiTexCoord0.st;
   Normal = normalize(gl_NormalMatrix * gl_Normal);
   Position = vec3(gl_ModelViewMatrix * gl_Vertex);
   
   gl_Position = ftransform();
}
