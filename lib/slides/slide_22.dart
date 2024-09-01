import 'package:a_closer_look_at_the_blur_effect/spacing.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide22 extends FlutterDeckSlideWidget {
  const Slide22()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/22',
            title: '22',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(Spacing.xxl),
          child: Center(
            child: Text(
              'This Ideal for pre-caching, offline rendering, and backend operations.',
              style: TextStyles.title,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
