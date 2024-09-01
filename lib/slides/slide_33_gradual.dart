import 'package:a_closer_look_at_the_blur_effect/slides/slide_30_box_blur.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class Slide33 extends FlutterDeckSlideWidget {
  const Slide33()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/33',
            title: '33',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    String code = """
#version 460 core
precision mediump float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uViewSize;
uniform sampler2D uTexture;

float sigma = 15.5;

out vec4 FragColor;

float normpdf(in float x, in float sigma)
{
    return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
}

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 uv = fragCoord / uViewSize;

    vec4 color = vec4(texture(uTexture, uv).rgb, 1.0);

    if(fragCoord.y > uViewSize.y * 0.8) { 
        // How much the shift is visible.
        const float shiftPower = 4.0;

        //declare stuff
        //The bigger the value the slower the effect
        const int mSize = 55;
        const int kSize = (mSize-1)/2;
        float kernel[mSize];
        vec3 final_colour = vec3(0.0);

        //create the 1-D kernel
        float Z = 0.00;
        for (int j = 0; j <= kSize; ++j)
        kernel[kSize+j] = kernel[kSize-j] = normpdf(float(j), sigma );

        //get the normalization factor (as the gaussian has been clamped)
        for (int j = 0; j < mSize; ++j)
        Z += kernel[j];

        //read out the texels
        for (int i=-kSize; i <= kSize; ++i)
        {
            for (int j=-kSize; j <= kSize; ++j)
            final_colour += kernel[kSize+j]*kernel[kSize+i]*texture(uTexture, (fragCoord.xy+vec2(float(i),float(j))) / uViewSize).rgb;
        }

        // Blend factor for the effect
        float val = clamp(shiftPower * abs(uViewSize.y * 0.8 - fragCoord.y) / (uViewSize.y * 0.4), 0.0, 1.0);
        FragColor = vec4(final_colour/(Z*Z), 1.0) * val + color * (1.0 - val);
    } else {
        FragColor = color;
    }
}
""";
    return FlutterDeckSlide.custom(
      builder: (context) {
        return ShowCustomBlur(
          title: "Gradual",
          codeWidget: SyntaxView(
            code: code,
            syntax: Syntax.C,
            syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
            fontSize: 22.0,
            withZoom: false,
            expanded: true,
            selectable: false,
          ),
          shaderWidget: const ShaderWidget(name: 'tilt_shift_gaussian'),
        );
      },
    );
  }
}
