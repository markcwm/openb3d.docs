// Vignette Effect by RonTek
// https://www.blitzcoder.org/forum/topic.php?id=132

uniform sampler2D texture0;

uniform float Radius;
uniform float Softness;

void main() {   

    vec4 Color = texture2D(texture0, gl_TexCoord[0].xy);
    vec2 screenpos = gl_TexCoord[0].xy * vec2(1.0, -1.0);

    float dist = length(screenpos - 0.5);
    float vignette = smoothstep(Radius, Radius - Softness, dist);

    Color.rgb = mix(Color.rgb, Color.rgb * vignette, 1.0);
    gl_FragColor = Color;
}
