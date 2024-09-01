import 'package:a_closer_look_at_the_blur_effect/spacing.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide12 extends FlutterDeckSlideWidget {
  const Slide12()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/12',
            title: '12',
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
              'Those are the building blocks, are they flexible enough?',
              style: TextStyles.title,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
