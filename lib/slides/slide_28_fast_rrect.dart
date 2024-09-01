import 'package:a_closer_look_at_the_blur_effect/slides/slide_27_speedup_gaussian.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
        Text('RRect Blur', style: TextStyles.title),
        const SizedBox(height: 20),
        Expanded(child: FastRRect()),
        const SizedBox(height: 80),
      ],
    );
  }
}

class FastRRect extends StatefulWidget {
  const FastRRect({Key? key}) : super(key: key);

  @override
  _FastRRectState createState() => _FastRRectState();
}

class _FastRRectState extends State<FastRRect> {
  double _sliderValue = 0.0;

  final List<String> blurMethods = [
    'Constant Time (Per shader)',
    'Analytical Solution - works with known shapes RRect',
    'Approximation and not true Gaussian',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow,
                    blurRadius: _sliderValue * 80,
                    spreadRadius: _sliderValue * 20,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Blur Shadow',
                  style: TextStyle(color: Colors.yellow, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        Slider(
          value: _sliderValue,
          onChanged: (newValue) {
            setState(() {
              _sliderValue = newValue;
            });
          },
          min: 0.0,
          max: 1.0,
        ),
        SizedBox(height: 20),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: blurMethods.asMap().entries.map((entry) {
                final index = entry.key;
                final method = entry.value;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            method,
                            style: TextStyles.subtitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
