import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide34 extends FlutterDeckSlideWidget {
  const Slide34()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/34',
            title: '34',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Code(slides) on Github',
                style: TextStyles.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.network("https://i.imgur.com/Bq2d6nx.png"),
            ],
          ),
        );
      },
    );
  }
}
