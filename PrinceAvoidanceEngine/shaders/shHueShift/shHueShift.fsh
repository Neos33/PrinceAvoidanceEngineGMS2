// A sample PShader for use with objPShaderEffect, objPShaderChain and objPShaderRectangle.
// The Fragment Shader has two uniforms: time and intensity

// time: time in seconds (increments by 1/50 every frame)
// intensity: a variable between 0 and 1 determining the intensity (or some other arbitrary parameter) of a shader effect
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;
uniform float intensity;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

void main()
{
    vec4 texColour = texture2D( gm_BaseTexture, v_vTexcoord );
    vec3 texColourHSV = rgb2hsv(texColour.xyz);
    vec3 maskIntensity = vec3(0.01*intensity,0.0,0.0);
    vec3 shiftedColour = hsv2rgb(texColourHSV+maskIntensity);
    
    
    gl_FragColor = v_vColour * vec4(shiftedColour,texColour.w);
}
