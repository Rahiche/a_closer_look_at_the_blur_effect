import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Slide8 extends FlutterDeckSlideWidget {
  const Slide8()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/8',
            title: '8',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const BlurMethodsSlide();
      },
    );
  }
}

class BlurMethodsSlide extends StatelessWidget {
  const BlurMethodsSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> blurMethods = [
      'Shadow',
      'MaskFilter',
      'ImageFilter',
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Ways to achieve blur in Flutter:',
            style: FlutterDeckTheme.of(context).textTheme.title,
          ),
        ),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: blurMethods.asMap().entries.map((entry) {
                final index = entry.key;
                final method = entry.value;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            method,
                            style: TextStyles.bodyText,
                          ),
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(
                          delay: Duration(milliseconds: 500 * index),
                          duration: 500.ms)
                      .slideX(
                          begin: 0.5,
                          end: 0,
                          delay: Duration(milliseconds: 500 * index),
                          duration: 500.ms,
                          curve: Curves.easeOutQuad),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
