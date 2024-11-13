//
// Simple passthrough fragment shader
//

//taken from https://www.shadertoy.com/view/XltGRf

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float intensity;

float hash( vec2 p ) {
    float h = dot(p + time * 0.0001,vec2(127.1,311.7));
    return fract(sin(h)*43758.5453123);
}
float hash2( vec2 p ) {
    float h = dot(p ,vec2(127.1,311.7));
    return fract(sin(h)*43758.5453123);
}

float noise( in vec2 p ) {
    vec2 i = floor( p );
    vec2 f = fract( p );
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( hash( i + vec2(0.0,0.0) ), 
                     hash( i + vec2(1.0,0.0) ), u.x),
                mix( hash( i + vec2(0.0,1.0) ), 
                     hash( i + vec2(1.0,1.0) ), u.x), u.y);
}
void main()
{
    vec2 uv = v_vTexcoord;
    
    float glitch = hash2(floor(time * 4.0 - uv * 20.0) / 20.0);
    uv += pow(abs(fract(glitch + time * 0.1)), 30.0);
    
    float n = pow(abs((noise(uv * 150.0) + noise(uv * 350.0)) * 0.5), 3.0);
    n *= abs(sin(uv.y * 250.0 + time * 2.0));
    float offset = sign(sin(uv.x * 6.0 + time * 3.0)) * 0.1;
    offset += sign(sin(uv.y * 10.0 + uv.x * 14.5 + time * 20.0)) * 0.1;
    offset += sign(sin(sin(time) * uv.y * 12.0 - uv.x * 22.0 - time * 40.0)) * 0.2;
    offset = pow(abs(offset - 0.5), 4.0);
        
    n *= min(1.0, floor((1.5 - uv.y + offset) * 3.0) / 3.0);
    
    float waver = abs(noise(vec2(time * 3.7)) * 2.0);
    n *= pow(abs(fract(floor(uv.y * 15.0) / 15.0 + time * 0.3) * waver * 0.4 + 0.4), 0.65);
    n *= 0.75 + waver * 0.125;
    n = clamp(n, 0.0, 1.0);
    
    gl_FragColor = vec4(vec3(n),n*intensity);
}