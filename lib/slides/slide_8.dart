import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide8 extends FlutterDeckSlideWidget {
  const Slide8()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/8',
            title: '8',
          ),
        );

  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'What are the possible ways to ahve blur in flutter: ImageFiltered , BackdropFilter, Container with boxShadow, CustomPainter',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
