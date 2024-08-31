import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide4 extends FlutterDeckSlideWidget {
  const Slide4()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/4',
            title: '4',
          ),
        );

  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Column(
            children: [
              Text(
                'Back to the 20th century',
                style: TextStyles.title,
              ),
            ],
          ),
        );
      },
    );
  }
}
