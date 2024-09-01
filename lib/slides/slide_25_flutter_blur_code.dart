import 'dart:ui';

import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Slide25 extends FlutterDeckSlideWidget {
  const Slide25()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/25',
            title: '25',
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
        Text('How Flutter blur works', style: TextStyles.title),
        const SizedBox(height: 20),
        Expanded(
            child: AnimatedImageCarousel(
          imageUrls: [
            "https://i.imgur.com/2VTlUTd.png",
            "https://i.imgur.com/QjvJagO.png",
            "https://i.imgur.com/ssCpBWP.png",
            "https://i.imgur.com/LLkouQV.png",
            "https://i.imgur.com/fqSzEQe.png",
          ],
        )),
        const SizedBox(height: 80),
      ],
    );
  }
}

class AnimatedImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final Duration animationDuration;

  const AnimatedImageCarousel({
    Key? key,
    required this.imageUrls,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _AnimatedImageCarouselState createState() => _AnimatedImageCarouselState();
}

class _AnimatedImageCarouselState extends State<AnimatedImageCarousel> {
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final nextPage = (_pageController.page?.round() ?? 0) + 1;
        if (nextPage < widget.imageUrls.length) {
          _pageController.animateToPage(
            nextPage,
            duration: Duration(milliseconds: 900),
            curve: Curves.easeInOut,
          );
        }
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return _buildImage(index);
        },
      ),
    );
  }

  Widget _buildImage(int index) {
    double distance = (_currentPage - index).abs();
    double scale = 1.0 - (distance * 0.3).clamp(0.0, 0.3);
    double blur = distance * 5;

    return Transform.scale(
      scale: scale,
      child: AnimatedOpacity(
        duration: widget.animationDuration,
        opacity: distance < 0.5 ? 1.0 : 0.5,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: blur,
            sigmaY: blur,
          ),
          child: AnimatedContainer(
            duration: widget.animationDuration,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
