// Simple switchable colorgrading as post process
// https://www.syntaxbomb.com/index.php/topic,3864.0.html
// https://www.blitzcoder.org/forum/topic.php?id=228

#extension GL_ARB_shader_texture_lod : enable

uniform sampler2D texture0;
uniform sampler2D lutMap;
uniform float luter;

vec3 color_grade(vec3 col3)
{
	float lmip = clamp((1.0 - col3.b), 0.00001, 0.99999) * 30.999;
	lmip = clamp(lmip, 0.0, 30.8);
	float lmip1 = floor(lmip);
	lmip = fract(lmip);
	vec2 llook = vec2(clamp((1.0 - col3.x) * 0.985, 0.017, 0.9999) * 0.03125 + lmip1 * 0.03125, 0.015 + col3.g * 0.981);
	llook.g = clamp(llook.g, 0.0, 0.983);
	vec2 llook2 = llook;
	llook2.x += 0.03125;
	llook.y = 1.0 - llook.y;
	llook2.y = 1.0 - llook2.y;
	
	llook.y *= 0.125;
	llook.y += luter * 0.125;
	llook2.y *= 0.125;
	llook2.y += luter * 0.125;

	return mix(texture2DLod(lutMap, llook, 0.0).rgb, texture2DLod(lutMap, llook2, 0.0).rgb, lmip);
}


void main()
{
	vec3 tc = texture2D(texture0, gl_TexCoord[0].st).rgb;
    vec3 color = color_grade(tc);
    gl_FragColor = vec4(color, 1.0);
}
