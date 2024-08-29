import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide19 extends FlutterDeckSlideWidget {
  const Slide19()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/19',
            title: '19',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'What does a blur do behind the scenes, example blured and not blured image',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
