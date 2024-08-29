import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide10 extends FlutterDeckSlideWidget {
  const Slide10()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/10',
            title: '10',
          ),
        );

  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'BackdropFilter',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
