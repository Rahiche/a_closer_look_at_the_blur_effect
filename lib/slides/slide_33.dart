import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide33 extends FlutterDeckSlideWidget {
  const Slide33()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/33',
            title: '33',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Gradual Blur',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
