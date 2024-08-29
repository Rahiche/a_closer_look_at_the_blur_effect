import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide22 extends FlutterDeckSlideWidget {
  const Slide22()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/22',
            title: '22',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Writing the example using Rust',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
