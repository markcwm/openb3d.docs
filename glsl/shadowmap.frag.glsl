// https://sourceforge.net/projects/minib3d/files/OB3DPlus%200.1%20src.tar.gz/download

varying vec4 shadowCoordinate;
varying vec3 normal;
varying vec4 vpos, lightPos;
 
uniform sampler2DShadow depthSampler;

uniform sampler2D Diffuse;

 
void main() {
	float shadow = 1.0;
	shadow = shadow2DProj(depthSampler, shadowCoordinate).r;
	vec4 col=texture2D(Diffuse, gl_TexCoord[0].xy);
	vec3 lightDir=vec3(lightPos-vpos);
	float NdotL = max(dot(normalize(normal),normalize(lightDir)),0.0)*shadow;

	gl_FragColor = col*NdotL;
}
