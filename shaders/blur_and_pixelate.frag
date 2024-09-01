#version 460 core
precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform sampler2D iChannel0;

out vec4 fragColor;

const float pixelSize = 10.0; 
const float radius = 5.0; 
const int samples = 10; 
    
void main()
{
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 uv = fragCoord/iResolution.xy;
    vec3 col = vec3(0.0);
    
    // Apply blur
    for(int x = -samples/2; x <= samples/2; x++)
    {
        for(int y = -samples/2; y <= samples/2; y++)
        {
            vec2 samplePos = uv + vec2(x, y) * (radius / iResolution.xy);
            col += pow(texture(iChannel0, samplePos).rgb, vec3(2.2));
        }
    }
    col /= float((samples + 1) * (samples + 1));
    
    // Apply pixelation after blur
    vec2 pixelatedUV = floor(uv * iResolution.xy / pixelSize) * pixelSize / iResolution.xy;
    vec3 pixelatedCol = pow(texture(iChannel0, pixelatedUV).rgb, vec3(2.2));
    
    // Blend the blurred color with the pixelated color
    col = mix(col, pixelatedCol, 0.5);
    
    fragColor = vec4(pow(col, vec3(1.0/2.2)), 1.0);
}