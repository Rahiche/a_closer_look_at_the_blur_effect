import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'dart:ui' as ui;

class Slide11 extends FlutterDeckSlideWidget {
  const Slide11()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/11',
            title: '11',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return ImageFilterPlaygroundSlide();
      },
    );
  }
}

class ImageFilterPlaygroundSlide extends StatefulWidget {
  @override
  _ImageFilterPlaygroundSlideState createState() =>
      _ImageFilterPlaygroundSlideState();
}

class _ImageFilterPlaygroundSlideState
    extends State<ImageFilterPlaygroundSlide> {
  double _sigmaX = 0.0;
  double _sigmaY = 0.0;
  double _combinedSigma = 0.0;
  bool _useCombinedBlur = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('ImageFilter Playground', style: TextStyles.subtitle),
        SizedBox(height: 20),
        Expanded(
          child: Row(
            children: [
              // Left side: Filtered image
              Expanded(
                flex: 2,
                child: Center(
                  child: ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(
                      sigmaX: _useCombinedBlur ? _combinedSigma : _sigmaX,
                      sigmaY: _useCombinedBlur ? _combinedSigma : _sigmaY,
                    ),
                    child: Image.network(
                      'https://picsum.photos/500/300',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Right side: Controls
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SwitchListTile(
                        title: Text('Use Combined Blur'),
                        value: _useCombinedBlur,
                        onChanged: (bool value) {
                          setState(() {
                            _useCombinedBlur = value;
                            if (value) {
                              _combinedSigma = (_sigmaX + _sigmaY) / 2;
                            } else {
                              _sigmaX = _combinedSigma;
                              _sigmaY = _combinedSigma;
                            }
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      if (_useCombinedBlur)
                        Column(
                          children: [
                            Text('Combined Blur',
                                style: Theme.of(context).textTheme.titleMedium),
                            Slider(
                              value: _combinedSigma,
                              max: 20,
                              divisions: 100,
                              label: _combinedSigma.toStringAsFixed(1),
                              onChanged: (value) =>
                                  setState(() => _combinedSigma = value),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            Text('Blur X',
                                style: Theme.of(context).textTheme.titleMedium),
                            Slider(
                              value: _sigmaX,
                              max: 20,
                              divisions: 100,
                              label: _sigmaX.toStringAsFixed(1),
                              onChanged: (value) =>
                                  setState(() => _sigmaX = value),
                            ),
                            SizedBox(height: 20),
                            Text('Blur Y',
                                style: Theme.of(context).textTheme.titleMedium),
                            Slider(
                              value: _sigmaY,
                              max: 20,
                              divisions: 100,
                              label: _sigmaY.toStringAsFixed(1),
                              onChanged: (value) =>
                                  setState(() => _sigmaY = value),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
