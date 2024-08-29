import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide16 extends FlutterDeckSlideWidget {
  const Slide16()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/16',
            title: '16',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'saturated blur',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
