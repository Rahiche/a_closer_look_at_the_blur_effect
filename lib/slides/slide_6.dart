import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide6 extends FlutterDeckSlideWidget {
  const Slide6()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/6',
            title: '6',
          ),
        );

  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'So how can we achive somthing simmilar to this in flutter ?',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
