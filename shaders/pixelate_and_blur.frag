const float pixelSize = 10.0; 
const float radius = 5.0; 
const int samples = 10; 
    
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    // Apply pixelation first
    vec2 pixelatedUV = floor(uv * iResolution.xy / pixelSize) * pixelSize / iResolution.xy;
    vec3 pixelatedCol = pow(texture(iChannel0, pixelatedUV).rgb, vec3(2.2));
    
    // Apply blur after pixelation
    vec3 col = vec3(0.0);
    for(int x = -samples/2; x <= samples/2; x++)
    {
        for(int y = -samples/2; y <= samples/2; y++)
        {
            vec2 samplePos = pixelatedUV + vec2(x, y) * (radius / iResolution.xy);
            vec2 samplePixelatedUV = floor(samplePos * iResolution.xy / pixelSize) * pixelSize / iResolution.xy;
            col += pow(texture(iChannel0, samplePixelatedUV).rgb, vec3(2.2));
        }
    }
    col /= float((samples + 1) * (samples + 1));
    
    // Output the final color
    fragColor = vec4(pow(col, vec3(1.0/2.2)), 1.0);
}