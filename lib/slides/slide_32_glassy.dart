import 'package:a_closer_look_at_the_blur_effect/slides/slide_30_box_blur.dart';
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
uniform float value;
uniform sampler2D uTexture;

out vec4 FragColor;

float random2 (in vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))* 43758.5453123);
}

vec2 myPattern(in vec2 uv){
    vec2 uv2 = uv;

    vec2 center = vec2(0.5, 0.5);

    // Determine if we're on the left/right and top/bottom of the center
    float xSign = sign(center.x - uv.x);
    float ySign = sign(center.y - uv.y);

    uv2.x = uv2.x + xSign * value * (random2(uv));
    uv2.y += ySign * value * (random2(uv));

    return uv2 - uv;
}

void main ()
{
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 iResolution = uViewSize;
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 p = uv;
    for (int i = 0; i < 10; i ++) {
         if (i % 2 == 1) {
            p -= myPattern(p) * 0.1;
        } else {
            p += myPattern(p) * 0.01;
        }

        vec3 col = texture(uTexture, p).rgb;
        FragColor = vec4 (col, 1.);
    } 
}
""";
    return FlutterDeckSlide.custom(
      builder: (context) {
        return ShowCustomBlur(
          title: "Glassy",
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
