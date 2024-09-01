import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class ShaderWidget extends StatefulWidget {
  const ShaderWidget({super.key, required this.name});
  final String name;

  @override
  State<ShaderWidget> createState() => _ShaderWidgetState();
}

class _ShaderWidgetState extends State<ShaderWidget> {
  bool _applyShader = false;
  double _shaderValue = 0.5; // Default shader value

  @override
  void initState() {
    super.initState();
    _delayBlurEffect();
  }

  void _delayBlurEffect() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _applyShader = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: _applyShader
              ? ShaderBuilder(
                  (context, shader, child) {
                    return AnimatedSampler(
                      (image, size, canvas) {
                        shader.setFloat(0, size.width);
                        shader.setFloat(1, size.height);
                        if (widget.name == "glass") {
                          shader.setFloat(2, _shaderValue);
                        }
                        shader.setImageSampler(0, image);

                        canvas.drawRect(
                          Rect.fromLTWH(0, 0, size.width, size.height),
                          Paint()..shader = shader,
                        );
                      },
                      child: Image.asset(
                        "assets/room.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  assetKey: 'shaders/${widget.name}.frag',
                )
              : Image.asset("assets/room.png", fit: BoxFit.cover),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Switch(
            value: _applyShader,
            onChanged: (value) {
              setState(() {
                _applyShader = value;
              });
            },
          ),
        ),
        if (_applyShader && widget.name == "glass")
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Slider(
              value: _shaderValue,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _shaderValue = value;
                });
              },
            ),
          ),
      ],
    );
  }
}

class ShowCustomBlur extends StatelessWidget {
  const ShowCustomBlur(
      {super.key,
      required this.title,
      required this.shaderWidget,
      required this.codeWidget});

  final String title;
  final Widget shaderWidget;
  final Widget codeWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            children: [
              Expanded(child: shaderWidget),
              Expanded(child: codeWidget),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class Slide30 extends FlutterDeckSlideWidget {
  const Slide30()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/30',
            title: '30',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    String code = """
#include <flutter/runtime_effect.glsl>

uniform vec2 uViewSize;
uniform sampler2D uTexture;

out vec4 FragColor;

const int BLUR_SIZE = 15;

void main() {
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 uv = fragCoord / uViewSize;

    vec4 color = vec4(0.0);
    for (int y = -BLUR_SIZE; y <= BLUR_SIZE; y++) {
        for (int x = -BLUR_SIZE; x <= BLUR_SIZE; x++) {
            vec2 offset = vec2(x, y) / uViewSize;
            color += texture(uTexture, uv + offset);
        }
    }

    FragColor = color / pow(float(BLUR_SIZE * 2 + 1), 2.0);  // Dividing by the total number of samples
}
""";
    return FlutterDeckSlide.custom(
      builder: (context) {
        return ShowCustomBlur(
          title: "Box Blur",
          codeWidget: SyntaxView(
            code: code,
            syntax: Syntax.C,
            syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
            fontSize: 22.0,
            withZoom: false,
            expanded: true,
            selectable: false,
          ),
          shaderWidget: const ShaderWidget(name: 'box'),
        );
      },
    );
  }
}
