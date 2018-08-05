// Screen Space Ambient Occlusion by RonTek
// https://www.blitzcoder.org/forum/topic.php?id=151

uniform sampler2D colortex;
uniform sampler2D depthtex;

vec2 fragCoords = gl_FragCoord.xy;

const float PI = 3.14159265;

uniform float width; // render target width
uniform float height; // render target height

uniform int onlyAO;

uniform float near;
uniform float far;

uniform int samples;
uniform int rings;

vec2 texCoord = gl_TexCoord[0].st;

vec2 rand(in vec2 coord) {
    float noiseX = (fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453));
    float noiseY = (fract(sin(dot(coord, vec2(12.9898, 78.233) * 2.0)) * 43758.5453));
    return vec2(noiseX, noiseY) * 0.004;
}

float readDepth(in vec2 coord) {
    return (2.0 * near) / (far + near - texture2D(depthtex, coord).x * (far - near));
}

float compareDepths(in float depth1, in float depth2) {
    float aoCap = 1.0;
    float aoMultiplier = 100.0;
    float depthTolerance = 0.0000;
    float aorange = 60.0;
    float diff = sqrt(clamp(1.0 - (depth1 - depth2) / (aorange / (far - near)), 0.0, 1.0));
    float ao = min(aoCap, max(0.0, depth1 - depth2 - depthTolerance) * aoMultiplier) * diff;
    return ao;
}

void main() {
    float depth = readDepth(texCoord);
    float d;

    float aspect = width / height;
    vec2 noise = rand(texCoord);

    float w = (1.0 / width) / clamp(depth, 0.05, 1.0) + (noise.x * (1.0 - noise.x));
    float h = (1.0 / height) / clamp(depth, 0.05, 1.0) + (noise.y * (1.0 - noise.y));

    float pw;
    float ph;

    float ao;
    float s;

    for (int i = -rings; i < rings; i += 1) {
        for (int j = -samples; j < samples; j += 1) {
            float step = PI * 2.0 / float(samples * i);
            pw = (cos(float(j) * step) * float(i));
            ph = (sin(float(j) * step) * float(i)) * aspect;
            d = readDepth(vec2(texCoord.s + pw * w, texCoord.t + ph * h));
            ao += compareDepths(depth, d);
            s += 1.0;
        }
    }

    ao /= s;
    ao = 1.0 - ao;

    vec3 color = texture2D(colortex, texCoord).rgb;

    // Get luminance from colortex
    vec3 lumcoeff = vec3(0.299, 0.587, 0.114);
    float lum = dot(color.rgb, lumcoeff);
    vec3 luminance = vec3(lum, lum, lum);

    vec3 white = vec3(1.0, 1.0, 1.0);
    vec3 black = vec3(0.0, 0.0, 0.0);
    vec3 thres = vec3(0.2, 0.2, 0.2);

    luminance = clamp(max(black, luminance - thres) + max(black, luminance - thres) + max(black, luminance - thres), 0.0, 1.0);

    if (onlyAO!=0) {
        gl_FragColor = vec4(mix(vec3(ao, ao, ao), white, luminance), 1.0); // ambient occlusion only
    } else {
        gl_FragColor = vec4(color * mix(vec3(ao, ao, ao), white, luminance), 1.0);
    }
}
