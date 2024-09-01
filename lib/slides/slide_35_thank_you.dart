import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide35 extends FlutterDeckSlideWidget {
  const Slide35()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/35',
            title: '35',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank You!',
                style: TextStyles.title,
              ),
              const SizedBox(height: 20),
              Text(
                '@rahiche',
                style: TextStyles.subtitle,
              ),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }
}
