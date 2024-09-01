import 'package:a_closer_look_at_the_blur_effect/spacing.dart';
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
        return Padding(
          padding: const EdgeInsets.all(Spacing.xxl),
          child: Center(
            child: Text(
              'Awesome stuff '
              'But that is not enough contorl for a progammer, we want access the pixel level right?',
              style: TextStyles.title,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
