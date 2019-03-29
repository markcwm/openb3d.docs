// Depth of Field by RonTek
// https://www.blitzcoder.org/forum/topic.php?id=211

varying vec2 texCoords;
varying vec4 texCoord1;

uniform sampler2D depthtex;
uniform sampler2D colortex;

uniform float blursize; // 0.002
uniform float minblur;
uniform float maxblur;
uniform float bb_zNear; // 0.5
uniform float bb_zFar; // 1000.0

uniform float rt_w; // render target width
uniform float rt_h; // render target height

void main()
{
	float center = 0.0;
	vec2 bb_ViewportSize = vec2(rt_w, rt_h);

	float x = texCoords.x;
	float y = texCoords.y;

	vec4 pixel = texture2D(colortex, texCoords);
	vec4 blurFactor = texture2D(depthtex, texCoord1.st) * blursize;
	float bf = blurFactor.r;
	vec4 blurSample = vec4(0.0, 0.0, 0.0, 0.0);

	int lo = 2; // 2
	int hi = 3; // 3
	for(int tx =-lo; tx<hi; tx++){
		for(int ty =-lo; ty<hi; ty++){
			vec2 uv = texCoords.st;
			uv.x = uv.x + float(tx) * bf;
			uv.y = uv.y + float(ty) * bf;
			blurSample = blurSample + texture2D(colortex, uv);
		}   
	}
	float darken = 4.0 * float(hi * lo); // 23
	blurSample = blurSample / darken;

	float fragz = texture2D(depthtex, texCoords).r;
	fragz = bb_zNear * bb_zFar / (fragz * (bb_zNear - bb_zFar) + bb_zFar);
	float maxblur2 = center + maxblur; 
	if (fragz > maxblur2){
		fragz = maxblur2;
	}else if (fragz < minblur){
			fragz = minblur;
	}

	float mx = 0.0;
	float div; // Distance from world at center pixel to min/max distance...
	if (fragz > center){
		div = 1.0 / (maxblur2 - center);
		mx = (fragz - center) * div;
	}else{
		div = 1.0 / (center - minblur);
		mx = (center - fragz) * div;
	}

	pixel = mix(pixel, blurSample, mx);
	if (int(texCoords.x) == int(bb_ViewportSize.x) && int(texCoords.y) == int(bb_ViewportSize.y)){
		pixel = vec4 (1.0, 1.0, 1.0, 1.0);
	}

	gl_FragColor = pixel;
}
