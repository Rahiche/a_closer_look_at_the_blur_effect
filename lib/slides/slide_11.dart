import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide11 extends FlutterDeckSlideWidget {
  const Slide11()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/11',
            title: '11',
          ),
        );

  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'BoxShadow',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
