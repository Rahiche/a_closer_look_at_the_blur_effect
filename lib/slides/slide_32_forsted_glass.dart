import 'package:a_closer_look_at_the_blur_effect/slides/slide_30_box_blur.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class Slide32 extends FlutterDeckSlideWidget {
  const Slide32()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/32',
            title: '32',
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

const int SAMPLE_COUNT = 10;
const float blurSize = 4.0;  // You can vary this to increase or decrease the blurriness.

out vec4 FragColor;

vec4 blur(vec2 uv) {
    vec4 accumulatedColor = vec4(0.0);
    for (int i = 0; i < SAMPLE_COUNT; i++) {
        float angle = 2.0 * 3.14159265359 * float(i) / float(SAMPLE_COUNT);
        vec2 offset = vec2(cos(angle), sin(angle)) * blurSize / uViewSize;
        accumulatedColor += texture(uTexture, uv + offset);
    }
    return accumulatedColor / float(SAMPLE_COUNT);
}

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 uv = fragCoord / uViewSize;
    FragColor = blur(uv);
}
""";
    return FlutterDeckSlide.custom(
      builder: (context) {
        return ShowCustomBlur(
          title: "Frosted Glass",
          codeWidget: SyntaxView(
            code: code,
            syntax: Syntax.C,
            syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
            fontSize: 22.0,
            withZoom: false,
            expanded: true,
            selectable: false,
          ),
          shaderWidget: const ShaderWidget(name: 'glass'),
        );
      },
    );
  }
}
