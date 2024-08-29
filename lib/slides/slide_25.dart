import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide25 extends FlutterDeckSlideWidget {
  const Slide25()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/25',
            title: '25',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'How Flutter blur works, code tracing',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
