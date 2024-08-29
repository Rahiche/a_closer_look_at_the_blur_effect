import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide26 extends FlutterDeckSlideWidget {
  const Slide26()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/26',
            title: '26',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Different blur paths by Flutter',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
