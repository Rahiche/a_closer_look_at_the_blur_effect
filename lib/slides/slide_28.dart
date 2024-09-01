import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide28 extends FlutterDeckSlideWidget {
  const Slide28()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/28',
            title: '28',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return _SlideContent();
      },
    );
  }
}

class _SlideContent extends StatelessWidget {
  const _SlideContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('RRect Blur', style: TextStyles.title),
        const SizedBox(height: 20),
        // Expanded(child: MipmapDemoWidget()),

        // constat time
        // analytical soliotn
        // approximation and not true gaussian
      ],
    );
  }
}
