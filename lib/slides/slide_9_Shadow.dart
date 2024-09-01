import 'package:a_closer_look_at_the_blur_effect/spacing.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide9 extends FlutterDeckSlideWidget {
  const Slide9()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/9',
            title: '9',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const ShadowPlaygroundSlide();
      },
    );
  }
}

class ShadowPlaygroundSlide extends StatefulWidget {
  const ShadowPlaygroundSlide({super.key});

  @override
  _ShadowPlaygroundSlideState createState() => _ShadowPlaygroundSlideState();
}

class _ShadowPlaygroundSlideState extends State<ShadowPlaygroundSlide> {
  double _blurRadius = 0.0;
  double _spreadRadius = 0.0;
  Offset _offset = const Offset(0, 4);
  final Color _shadowColor = Colors.white.withOpacity(0.3);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Shadow', style: TextStyles.title),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left side: Container with shadow
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.xxl),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: _shadowColor,
                              blurRadius: _blurRadius,
                              spreadRadius: _spreadRadius,
                              offset: _offset,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Shadow Example',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Right side: Sliders
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSlider('Blur Radius', _blurRadius, 0, 50,
                              (value) {
                            setState(() => _blurRadius = value);
                          }),
                          _buildSlider('Spread Radius', _spreadRadius, -10, 10,
                              (value) {
                            setState(() => _spreadRadius = value);
                          }),
                          _buildSlider('Offset X', _offset.dx, -20, 20,
                              (value) {
                            setState(() => _offset = Offset(value, _offset.dy));
                          }),
                          _buildSlider('Offset Y', _offset.dy, -20, 20,
                              (value) {
                            setState(() => _offset = Offset(_offset.dx, value));
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max,
      ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label)),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 50, child: Text(value.toStringAsFixed(1))),
        ],
      ),
    );
  }
}
