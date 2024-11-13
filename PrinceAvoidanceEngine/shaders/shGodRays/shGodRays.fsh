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

    vec2 center=vec2(0.5,0.5);
    vec4 baseColour =  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
    int depth=8;
    float scaleFactor=0.02;
    for(int i=0;i<depth;i++){
        baseColour+=texture2D( gm_BaseTexture, (1.0-intensity*scaleFactor*float(i))*(v_vTexcoord-center)+center)/float(i+2)*intensity;
    }
    gl_FragColor = baseColour;
}
