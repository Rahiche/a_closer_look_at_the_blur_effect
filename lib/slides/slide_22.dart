import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide22 extends FlutterDeckSlideWidget {
  const Slide22()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/22',
            title: '22',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const _SlideContent();
      },
    );
  }
}

class _SlideContent extends StatelessWidget {
  const _SlideContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('With Rust', style: TextStyles.title),
        const SizedBox(height: 20),
        // Expanded(child: InteractiveMarioPixelArt()),
      ],
    );
  }
}
