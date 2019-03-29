// God Rays from Max3D - port by RonTek
// https://www.blitzcoder.org/forum/topic.php?id=180

varying vec4 texCoord0;
varying vec4 texCoord1;

uniform sampler2D colortex;
uniform sampler2D depthtex;

uniform float GodRaysExposure;
uniform float GodRaysLightX;
uniform float GodRaysLightY;

uniform int Num_Samples; // 100

void main()
{
	vec3 GodRaysColor = vec3(1.0, 1.0, 0.5);

	vec2 textCoo = texCoord0.st;
	vec2 lightPos = vec2(GodRaysLightX, GodRaysLightY);
	vec2 deltaTextCoord = (textCoo - lightPos) / float(Num_Samples);

	vec3 color = vec3(0.0);

	for(int i = 0; i < Num_Samples; i++){
		textCoo -= deltaTextCoord;
		color += GodRaysColor * floor(texture2D(depthtex, textCoo).r);
	}

	gl_FragColor = texture2D(colortex, texCoord0.st) + vec4(color / float(Num_Samples) * GodRaysExposure, 0.0);
}
