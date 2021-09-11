// NFAA (Normal filter anti-aliasing) by RonTek
// https://www.blitzcoder.org/forum/topic.php?id=1068

uniform sampler2D texture0;
uniform vec2 resolution;

float width = resolution.x; //texture width
float height = resolution.y; //texture height

vec2 inverse_buffer_size = vec2(1.0/width, 1.0/height);
vec2 texCoord = gl_TexCoord[0].st;

float lumRGB(vec3 v) { 
  return dot(v, vec3(0.212, 0.716, 0.072));
}

vec2 vPixelViewport = vec2(1.0/width, 1.0/height);
const float fScale = 3.0;

void main() {

  // Offset coordinates

  vec2 upOffset = vec2(0.0, vPixelViewport.y) * fScale;
  vec2 rightOffset = vec2(vPixelViewport.x, 0.0) * fScale;

  float topHeight = lumRGB( texture2D(texture0, texCoord.xy + upOffset).rgb );
  float bottomHeight = lumRGB( texture2D(texture0, texCoord.xy - upOffset).rgb );
  float rightHeight = lumRGB( texture2D(texture0, texCoord.xy + rightOffset).rgb );
  float leftHeight = lumRGB( texture2D(texture0, texCoord.xy - rightOffset).rgb );
  float leftTopHeight = lumRGB( texture2D(texture0, texCoord.xy - rightOffset + upOffset).rgb );
  float leftBottomHeight = lumRGB( texture2D(texture0, texCoord.xy - rightOffset - upOffset).rgb );
  float rightBottomHeight = lumRGB( texture2D(texture0, texCoord.xy + rightOffset + upOffset).rgb );
  float rightTopHeight = lumRGB( texture2D(texture0, texCoord.xy + rightOffset - upOffset).rgb );

  // Normal map creation

  float sum0 = rightTopHeight + topHeight + rightBottomHeight;
  float sum1 = leftTopHeight + bottomHeight + leftBottomHeight;
  float sum2 = leftTopHeight + leftHeight + rightTopHeight;
  float sum3 = leftBottomHeight + rightHeight + rightBottomHeight;
  float vect1 = (sum1 - sum0);
  float vect2 = (sum2 - sum3);

  // Put them together and scale

  vec2 Normal = vec2(vect1, vect2); // * vPixelViewport * fScale;

  // Color

  //Normal.xy = clamp(Normal, -float2(1.0, 1.0) * 0.4, float2(1.0, 1.0) * 0.4); // Error: *** buffer overflow detected
  Normal.x = clamp(Normal.x, -float(1.0) * 0.4, float(1.0) * 0.4); // Prevent over-blurring in high-contrast areas
  Normal.y = clamp(Normal.y, -float(1.0) * 0.4, float(1.0) * 0.4);
  Normal.xy *= vPixelViewport * fScale;   // Increase pixel size to get more blur

  vec4 Scene0 = texture2D(texture0, texCoord.xy);
  vec4 Scene1 = texture2D(texture0, texCoord.xy + Normal.xy);
  vec4 Scene2 = texture2D(texture0, texCoord.xy - Normal.xy);
  vec4 Scene3 = texture2D(texture0, texCoord.xy + vec2(Normal.x, -Normal.y) * 0.5);
  vec4 Scene4 = texture2D(texture0, texCoord.xy - vec2(Normal.x, -Normal.y) * 0.5);

  // Final color

  gl_FragColor.rgb = (Scene0.rgb + Scene1.rgb + Scene2.rgb + Scene3.rgb + Scene4.rgb) * 0.2;
  //gl_FragColor.rgb = (vec3(Normal , 1.0) * 0.5 + 0.5);

  gl_FragColor.a = 1.0;
}
