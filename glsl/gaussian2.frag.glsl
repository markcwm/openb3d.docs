// gaussian blur
// https://www.freebasic.net/forum/viewtopic.php?f=14&t=15409&start=870

#version 120

uniform int PassNum;

uniform sampler2D RenderTex;

uniform int Width;
uniform int Height;

varying vec3 Position;
varying vec3 Normal;
varying vec2 TexCoord;

float PixOffset[7] = float[] (0.0,1.5,3.0,4.5,6.0,7.5,9.0);
//float PixOffset[5] = float[] (0.0,1.5,3.0,4.5,6.0);
//float PixOffset[5] = float[] (0.0,0.1,0.2,0.3,0.4);
//float Weight[5] = float[] (0.75,1.0,1.5,1.0,0.75);

float Weight[5] = float[] (0.05,0.14,0.2,0.14,0.05);
//float Weight[5] = float[] (0.001,0.02,0.23,0.02,0.001);
//float Weight[7] = float[] (0.015625,0.09375,0.234375,0.3125,0.234375,0.09375,0.015625);
//float Weight[7] = float[] (0.01562,0.0937,0.2343,0.3125,0.2343,0.0937,0.0156);

vec4 Pass1()
{
   float dy = 1.0 / float(Height);
   vec2 invTex = TexCoord * vec2(1.0, -1.0);
   vec4 sum = texture2D(RenderTex, invTex) * Weight[0];
   for (int i = 1; i < 5; i++){
      sum += texture2D(RenderTex, invTex + vec2(0.0,PixOffset[i]) * dy ) * Weight[i];
      sum += texture2D(RenderTex, invTex - vec2(0.0,PixOffset[i]) * dy ) * Weight[i];
   }
   return sum;
}

vec4 Pass2()
{
   float dx = 1.0 / float(Width);
   vec2 invTex = TexCoord * vec2(1.0, -1.0);
   vec4 sum = texture2D(RenderTex, invTex) * Weight[0];
   for (int i = 1; i < 5; i++){
      sum += texture2D(RenderTex, invTex + vec2(PixOffset[i],0.0) * dx ) * Weight[i];
      sum += texture2D(RenderTex, invTex - vec2(PixOffset[i],0.0) * dx ) * Weight[i];
   }
   return sum;
}


void main()
{
      gl_FragColor = Pass2();
}
