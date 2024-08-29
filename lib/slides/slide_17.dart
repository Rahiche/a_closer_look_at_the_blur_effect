import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide17 extends FlutterDeckSlideWidget {
  const Slide17()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/17',
            title: '17',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Smooth Edges',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
