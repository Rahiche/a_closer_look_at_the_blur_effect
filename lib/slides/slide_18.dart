import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide18 extends FlutterDeckSlideWidget {
  const Slide18()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/18',
            title: '18',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'But that is not enough contorl for a progammer, we want access the pixel level right?',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
