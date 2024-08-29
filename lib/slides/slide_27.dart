import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide27 extends FlutterDeckSlideWidget {
  const Slide27()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/27',
            title: '27',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Flutter blurring is fast',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
