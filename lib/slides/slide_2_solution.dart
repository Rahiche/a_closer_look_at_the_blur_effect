import 'package:a_closer_look_at_the_blur_effect/spacing.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Slide2 extends FlutterDeckSlideWidget {
  const Slide2()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/2',
            title: '2',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const Slide1Content();
      },
    );
  }
}

class Slide1Content extends StatefulWidget {
  const Slide1Content({super.key});

  @override
  State<Slide1Content> createState() => _Slide1ContentState();
}

class _Slide1ContentState extends State<Slide1Content> {
  bool _showNumberList = false;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showNumberList = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.xl),
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (!_showNumberList) {
                _showNumberList = true;
              } else {
                _currentStep++;
              }
            });
          },
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            curve: Curves.easeInOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Calculate the sum of all integers from 1 to 100',
                  style: TextStyles.title,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.sm),
                if (_showNumberList) NumberList(currentStep: _currentStep),
                if (_showNumberList && _currentStep > 0)
                  Text(
                    'Sum: 101',
                    style: TextStyles.bodyText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumberList extends StatelessWidget {
  final int currentStep;

  const NumberList({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: List.generate(100, (index) {
          int number = index + 1;
          bool isHighlighted = _shouldHighlight(number);

          return Text(
            '$number${number < 100 ? ' + ' : ''}',
            style: TextStyles.bodyText.copyWith(
              color: isHighlighted ? Colors.red : null,
              fontWeight: isHighlighted ? FontWeight.bold : null,
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: (index * 60).ms)
              .slideY(
                begin: 0.5,
                end: 0,
                duration: 600.ms,
                delay: (index * 60).ms,
              )
              .blur(
                delay: (index * 60).ms,
                duration: 600.ms,
                begin: const Offset(10, 10),
                end: const Offset(0, 0),
              );
        }),
      ),
    );
  }

  bool _shouldHighlight(int number) {
    if (currentStep == 0) return false;

    int pair1 = currentStep;
    int pair2 = 101 - currentStep;

    return number == pair1 || number == pair2;
  }
}
