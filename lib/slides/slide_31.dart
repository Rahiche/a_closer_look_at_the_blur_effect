import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide31 extends FlutterDeckSlideWidget {
  const Slide31()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/31',
            title: '31',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Lens blur',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
