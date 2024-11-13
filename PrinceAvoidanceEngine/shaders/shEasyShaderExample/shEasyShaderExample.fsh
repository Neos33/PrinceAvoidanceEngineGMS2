// A sample PShader for use with objPShaderEffect, objPShaderChain and objPShaderRectangle.
// The Fragment Shader has two uniforms: time and intensity

// time: time in seconds (increments by 1/50 every frame)
// intensity: a variable between 0 and 1 determining the intensity (or some other arbitrary parameter) of a shader effect
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;
uniform float intensity;

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + intensity*vec2(rand(vec2(v_vTexcoord.y,time))-0.5,0.0));
}
