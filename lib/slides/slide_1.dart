import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide1 extends FlutterDeckSlideWidget {
  const Slide1()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/1',
            title: '1',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const Text('1');
      },
    );
  }
}
