import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide0 extends FlutterDeckSlideWidget {
  const Slide0()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/0',
            title: '0',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'A Closer look at the blur effect',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
