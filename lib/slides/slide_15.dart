import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide15 extends FlutterDeckSlideWidget {
  const Slide15()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/15',
            title: '15',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'lens like blur',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
