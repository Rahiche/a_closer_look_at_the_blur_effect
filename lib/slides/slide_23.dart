import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide23 extends FlutterDeckSlideWidget {
  const Slide23()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/23',
            title: '23',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'This is good but for pre caching, offline rendering or for backend operation, we need real time',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
