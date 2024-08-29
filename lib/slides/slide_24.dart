import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide24 extends FlutterDeckSlideWidget {
  const Slide24()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/24',
            title: '24',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'GPU vs CPU',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}