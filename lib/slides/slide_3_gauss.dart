import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Slide3 extends FlutterDeckSlideWidget {
  const Slide3()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/3',
            title: '3',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const AnimatedCardsPage();
      },
    );
  }
}

class AnimatedCardsPage extends StatefulWidget {
  const AnimatedCardsPage({super.key});

  @override
  State<AnimatedCardsPage> createState() => _AnimatedCardsPageState();
}

class _AnimatedCardsPageState extends State<AnimatedCardsPage> {
  int _visibleCards = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startShowingCards();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startShowingCards() {
    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (mounted) {
        setState(() {
          if (_visibleCards < _cards.length) {
            _visibleCards++;
          } else {
            timer.cancel();
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  final List<Widget> _cards = [
    const CardWidget(
      child: Text(
        'The year is: 1784',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    ),
    CardWidget(
      child: Image.network(
        'https://i.imgur.com/DEnZd2a.png',
        fit: BoxFit.cover,
      ),
    ),
    const CardWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Carl Friedrich Gauss',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text('Age: 7', style: TextStyle(fontSize: 20)),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSize(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        duration: const Duration(milliseconds: 300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_cards.length, (index) {
            if (index < _visibleCards) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _cards[index]
                    .animate()
                    .fade(duration: const Duration(milliseconds: 500))
                    .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                        duration: const Duration(milliseconds: 500))
                    .slide(
                        begin: const Offset(0.2, 0),
                        end: Offset.zero,
                        duration: const Duration(milliseconds: 500)),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Widget child;

  const CardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 500,
        height: 700,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
