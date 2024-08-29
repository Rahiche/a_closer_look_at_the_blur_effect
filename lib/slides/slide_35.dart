import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide35 extends FlutterDeckSlideWidget {
  const Slide35()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/35',
            title: '35',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank You!',
                style: FlutterDeckTheme.of(context).textTheme.title,
              ),
              SizedBox(height: 20),
              Text(
                'Raouf Rahiche',
                style: FlutterDeckTheme.of(context).textTheme.subtitle,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialLink(
                    icon: Icons.abc,
                    url: 'https://github.com/raoufrahiche',
                    label: 'GitHub',
                  ),
                  SizedBox(width: 20),
                  _buildSocialLink(
                    icon: Icons.abc,
                    url: 'https://twitter.com/raoufrahiche',
                    label: 'Twitter',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialLink({
    required IconData icon,
    required String url,
    required String label,
  }) {
    return InkWell(
      child: Column(
        children: [
          Icon(icon, size: 30),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
