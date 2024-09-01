import 'package:a_closer_look_at_the_blur_effect/slides/slide_30_box_blur.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class Slide31 extends FlutterDeckSlideWidget {
  const Slide31()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/31',
            title: '31',
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
const float uBlurAmount = 0.6;

out vec4 FragColor;

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 uv = fragCoord / uViewSize;

    // Calculate an offset based on the blur amount. This can be adjusted to get the desired blur strength.
    float maxOffset = uBlurAmount * 5.0;

    vec4 finalColor = vec4(0.0);
    float totalWeight = 0.0;

    // Sample around the current pixel in a circular pattern
    for(float angle = 0.0; angle < 360.0; angle += 45.0) {
        float xOffset = cos(radians(angle)) * maxOffset;
        float yOffset = sin(radians(angle)) * maxOffset;
        vec4 sampleColor = texture(uTexture, uv + vec2(xOffset, yOffset) / uViewSize);

        // The weight decreases the further the sample is from the center
        float weight = 1.0 - distance(uv, uv + vec2(xOffset, yOffset) / uViewSize);

        finalColor += sampleColor * weight;
        totalWeight += weight;
    }

    FragColor = finalColor / totalWeight;
}
""";
    return FlutterDeckSlide.custom(
      builder: (context) {
        return ShowCustomBlur(
          title: "Lens Blur",
          codeWidget: SyntaxView(
            code: code,
            syntax: Syntax.C,
            syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
            fontSize: 22.0,
            withZoom: false,
            expanded: true,
            selectable: false,
          ),
          shaderWidget: const ShaderWidget(name: 'lens'),
        );
      },
    );
  }
}
