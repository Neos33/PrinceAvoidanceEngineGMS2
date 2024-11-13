// RGBA color to RGBA greyscale
//
// smooth transition based on u_colorFactor: 0.0 = original, 1.0 = greyscale
//
// http://www.johndcook.com/blog/2009/08/24/algorithms-convert-color-grayscale/
// "The luminosity method is a more sophisticated version of the average method.
// It also averages the values, but it forms a weighted average to account for human perception.
// We’re more sensitive to green than other colors, so green is weighted most heavily. The formula
// for luminosity is 0.21 R + 0.72 G + 0.07 B."
// https://gist.github.com/Volcanoscar/4a9500d240497d3c0228f663593d167a

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float intensity;
uniform float time;

void main() {
   vec4 sample = texture2D(gm_BaseTexture, v_vTexcoord);
   float gray = 0.21 * sample.r + 0.71 * sample.g + 0.07 * sample.b;
   gl_FragColor = vec4(sample.rgb * (1.0 - intensity) + (gray * intensity), sample.a);
}

