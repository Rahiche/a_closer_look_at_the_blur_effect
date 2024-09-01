import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'dart:ui';

class Slide18 extends FlutterDeckSlideWidget {
  const Slide18()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/18',
            title: '18',
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
        Text('Shader mask', style: TextStyles.title),
        const SizedBox(height: 20),
        Expanded(child: ShaderMaskDemo())
      ],
    );
  }
}

class ShaderMaskDemo extends StatefulWidget {
  static const String _imageUrl = 'https://i.imgur.com/sHuAqc7.png';
  static const double _scale = 1.2;
  static const double _blurSigma = 15.0;
  static const double _gradientStop1 = 0.4;
  static const double _gradientStop2 = 0.75;

  const ShaderMaskDemo({Key? key}) : super(key: key);

  @override
  _ShaderMaskDemoState createState() => _ShaderMaskDemoState();
}

class _ShaderMaskDemoState extends State<ShaderMaskDemo> {
  bool _showBackgroundImage = true;
  bool _showBlurredOverlay = true;
  bool _showShaderMask = true;
  bool _showBackdropFilter = true;
  bool _useCustomBlurredImage = false;
  double _blurSigma = ShaderMaskDemo._blurSigma;
  double _gradientStop1 = ShaderMaskDemo._gradientStop1;
  double _gradientStop2 = ShaderMaskDemo._gradientStop2;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRect(
            child: Center(
              child: SizedBox(
                width: 400,
                height: 300,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: <Widget>[
                    if (_showBackgroundImage) _buildBackgroundImage(),
                    if (_showBlurredOverlay) _buildBlurredOverlay(),
                  ],
                ),
              ),
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.network(
      ShaderMaskDemo._imageUrl,
      fit: BoxFit.cover,
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _buildBlurredOverlay() {
    Widget child = _useCustomBlurredImage
        ? _buildBackgroundImage()
        : Container(color: Colors.transparent);

    if (_showShaderMask) {
      child = ShaderMask(
        shaderCallback: (rect) => _createGradientShader(rect),
        blendMode: BlendMode.dstOut,
        child: child,
      );
    }

    if (_showBackdropFilter) {
      child = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
        child: child,
      );
    }

    return child;
  }

  Shader _createGradientShader(Rect rect) {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.black, Colors.transparent],
      stops: [_gradientStop1, _gradientStop2],
    ).createShader(rect);
  }

  Widget _buildControls() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Show Background Image'),
          value: _showBackgroundImage,
          onChanged: (value) {
            setState(() {
              _showBackgroundImage = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Show Blurred Overlay'),
          value: _showBlurredOverlay,
          onChanged: (value) {
            setState(() {
              _showBlurredOverlay = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Show Shader Mask'),
          value: _showShaderMask,
          onChanged: (value) {
            setState(() {
              _showShaderMask = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Show Backdrop Filter'),
          value: _showBackdropFilter,
          onChanged: (value) {
            setState(() {
              _showBackdropFilter = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Use Custom Blurred Image'),
          value: _useCustomBlurredImage,
          onChanged: (value) {
            setState(() {
              _useCustomBlurredImage = value;
            });
          },
        ),
        ListTile(
          title: const Text('Blur Sigma'),
          subtitle: Slider(
            value: _blurSigma,
            min: 0,
            max: 30,
            divisions: 30,
            label: _blurSigma.toStringAsFixed(1),
            onChanged: (value) {
              setState(() {
                _blurSigma = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Gradient Stop 1'),
          subtitle: Slider(
            value: _gradientStop1,
            min: 0,
            max: 1,
            divisions: 20,
            label: _gradientStop1.toStringAsFixed(2),
            onChanged: (value) {
              setState(() {
                _gradientStop1 = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Gradient Stop 2'),
          subtitle: Slider(
            value: _gradientStop2,
            min: 0,
            max: 1,
            divisions: 20,
            label: _gradientStop2.toStringAsFixed(2),
            onChanged: (value) {
              setState(() {
                _gradientStop2 = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
