import 'package:a_closer_look_at_the_blur_effect/spacing.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide13 extends FlutterDeckSlideWidget {
  const Slide13()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/13',
            title: '13',
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
              "Well, we can actually use them to do a lot of tricks.",
              style: TextStyles.title,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}