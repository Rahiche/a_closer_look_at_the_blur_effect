import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Slide29x extends FlutterDeckSlideWidget {
  const Slide29x()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/29x',
            title: '29x',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const AnimatedSize(
          duration: Duration(milliseconds: 800),
          curve: Curves.linear,
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          child: AnimatedQuestionAnswer(),
        );
      },
    );
  }
}

class AnimatedQuestionAnswer extends StatefulWidget {
  const AnimatedQuestionAnswer({super.key});

  @override
  _AnimatedQuestionAnswerState createState() => _AnimatedQuestionAnswerState();
}

class _AnimatedQuestionAnswerState extends State<AnimatedQuestionAnswer> {
  bool _showAnswer = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showAnswer = true;
        });
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q: How to create a customized blur?',
              style: TextStyles.title,
            ),
            if (_showAnswer) ...[
              const SizedBox(height: 16),
              Text(
                'A: Custom Fragment shaders',
                style: TextStyles.title,
              ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.5, end: 0)
            ],
          ],
        ),
      ),
    );
  }
}
