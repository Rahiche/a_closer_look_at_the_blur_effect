import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide5 extends FlutterDeckSlideWidget {
  const Slide5()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/5',
            title: '5',
          ),
        );

  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'Android have offical api for blur and ios have a new blur that they have since 2021 in ios 17 it is gradual blur that appears in home page of ios and in the maps application',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
