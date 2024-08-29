import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide28 extends FlutterDeckSlideWidget {
  const Slide28()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/28',
            title: '28',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'How to create a custimzaed blur?',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
