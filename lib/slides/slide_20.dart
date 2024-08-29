import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide20 extends FlutterDeckSlideWidget {
  const Slide20()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/20',
            title: '20',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Interactive example of the blur is generated',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}