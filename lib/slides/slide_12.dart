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

  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Those are the building blocks how far can we use them to construct what we want',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
