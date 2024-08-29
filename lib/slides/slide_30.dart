import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide30 extends FlutterDeckSlideWidget {
  const Slide30()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/30',
            title: '30',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'A simple box blur',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
