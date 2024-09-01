import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide7 extends FlutterDeckSlideWidget {
  const Slide7()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/7',
            title: '7',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Text(
            'one problem this is apple: the api is private so app might get rejected if you use it so we have to emulate it and in order to that we have to see the building blocks of using the blur effect',
            style: TextStyles.title,
          ),
        );
      },
    );
  }
}
