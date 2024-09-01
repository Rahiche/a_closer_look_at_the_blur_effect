import 'dart:ui';

import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide26 extends FlutterDeckSlideWidget {
  const Slide26()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/26',
            title: '26',
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
        Text('Not all Blurs are the same', style: TextStyles.title),
        const SizedBox(height: 20),
        const Expanded(child: BlurDemo()),
        const SizedBox(height: 80),
      ],
    );
  }
}

class BlurDemo extends StatefulWidget {
  const BlurDemo({super.key});

  @override
  _BlurDemoState createState() => _BlurDemoState();
}

class _BlurDemoState extends State<BlurDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Image with blur
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return SizedBox(
                    width: 400,
                    height: 400,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: _animation.value * 10,
                        sigmaY: _animation.value * 10,
                        tileMode: TileMode.decal,
                      ),
                      child: Image.network(
                        'https://picsum.photos/200',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Container with blur shadow
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                          blurRadius: _animation.value * 80,
                          spreadRadius: _animation.value * 20,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Blur Shadow',
                        style: TextStyle(color: Colors.yellow, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
