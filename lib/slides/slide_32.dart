import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

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
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Frosted glass',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
