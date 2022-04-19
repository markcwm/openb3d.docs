// https://en.wikibooks.org/wiki/GLSL_Programming/Unity/Diffuse_Reflection_of_Skylight

uniform sampler2D tex0;
uniform int usetex;

varying vec4 color; // the hemisphere lighting computed in the vertex shader

void main(){
	vec4 texval = texture2D(tex0, vec2(gl_TexCoord[0]));
	
	if(usetex == 1){
		gl_FragColor = (0.5 * texval) + (0.5 * color);
	}else if(usetex == 2){
		gl_FragColor = texval;
	}else{
		gl_FragColor = color;
	}
}
