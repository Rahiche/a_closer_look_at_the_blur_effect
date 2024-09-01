import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide29 extends FlutterDeckSlideWidget {
  const Slide29()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/29',
            title: '29',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Q: How to create a custimzaed blur?' + 'Custom Fragment shaders',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
