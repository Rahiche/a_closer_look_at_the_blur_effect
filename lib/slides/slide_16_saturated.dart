import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'dart:ui';
import 'package:device_frame/device_frame.dart';

class Slide16 extends FlutterDeckSlideWidget {
  const Slide16()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/16',
            title: '16',
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
        Text('Saturated Blur', style: TextStyles.title),
        const SizedBox(height: 20),
        Expanded(child: ColorMatrixAndBlur())
      ],
    );
  }
}

class ColorMatrixAndBlur extends StatefulWidget {
  const ColorMatrixAndBlur({Key? key}) : super(key: key);

  @override
  _ColorMatrixAndBlurState createState() => _ColorMatrixAndBlurState();
}

class _ColorMatrixAndBlurState extends State<ColorMatrixAndBlur> {
  double _blurSigma = 0.0;
  double _redScale = 1.0;
  double _greenScale = 1.0;
  double _blueScale = 1.0;
  double _additive = 0.0;
  bool _isColorFilterInner = true;
  bool _showDeviceFrame = true;
  bool _useColorFilter = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildDisplayWidget(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Blur Sigma: ${_blurSigma.toStringAsFixed(2)}'),
                Slider(
                  value: _blurSigma,
                  min: 0,
                  max: 10,
                  onChanged: (value) => setState(() => _blurSigma = value),
                ),
                SizedBox(height: 20),
                Text('Red Scale: ${_redScale.toStringAsFixed(2)}'),
                Slider(
                  value: _redScale,
                  min: 0,
                  max: 2,
                  onChanged: (value) => setState(() => _redScale = value),
                ),
                Text('Green Scale: ${_greenScale.toStringAsFixed(2)}'),
                Slider(
                  value: _greenScale,
                  min: 0,
                  max: 2,
                  onChanged: (value) => setState(() => _greenScale = value),
                ),
                Text('Blue Scale: ${_blueScale.toStringAsFixed(2)}'),
                Slider(
                  value: _blueScale,
                  min: 0,
                  max: 2,
                  onChanged: (value) => setState(() => _blueScale = value),
                ),
                Text('Additive: ${_additive.toStringAsFixed(2)}'),
                Slider(
                  value: _additive,
                  min: -1,
                  max: 1,
                  onChanged: (value) => setState(() => _additive = value),
                ),
                SizedBox(height: 20),
                Text('Color Matrix:'),
                for (int i = 0; i < 4; i++)
                  Row(
                    children: [
                      for (int j = 0; j < 5; j++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              _getMatrixValue(i, j).toStringAsFixed(2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Color Filter is:'),
                    Switch(
                      value: _isColorFilterInner,
                      onChanged: (value) =>
                          setState(() => _isColorFilterInner = value),
                    ),
                    Text(_isColorFilterInner ? 'Inner' : 'Outer'),
                  ],
                ),
                Row(
                  children: [
                    Text('Show Device Frame:'),
                    Switch(
                      value: _showDeviceFrame,
                      onChanged: (value) =>
                          setState(() => _showDeviceFrame = value),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Use Color Filter:'),
                    Switch(
                      value: _useColorFilter,
                      onChanged: (value) =>
                          setState(() => _useColorFilter = value),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _setPreset(true),
                      child: Text('Light Preset'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _setPreset(false),
                      child: Text('Dark Preset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisplayWidget() {
    Widget content = ImageFiltered(
      imageFilter: _buildImageFilter(),
      child: Image.network(
        'https://picsum.photos/400/600',
        fit: BoxFit.cover,
      ),
    );

    return _showDeviceFrame
        ? DeviceFrameView(imageFilter: _buildImageFilter())
        : content;
  }

  ImageFilter _buildImageFilter() {
    return ImageFilter.compose(
      outer: _isColorFilterInner
          ? ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma)
          : (_useColorFilter
              ? _buildColorFilter()
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0)),
      inner: _isColorFilterInner
          ? (_useColorFilter
              ? _buildColorFilter()
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0))
          : ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
    );
  }

  ColorFilter _buildColorFilter() {
    return ColorFilter.matrix([
      _redScale,
      0,
      0,
      0,
      0,
      0,
      _greenScale,
      0,
      0,
      0,
      0,
      0,
      _blueScale,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  double _getMatrixValue(int row, int col) {
    if (col == 4) return _additive;
    if (row == 0 && col == 0) return _redScale;
    if (row == 1 && col == 1) return _greenScale;
    if (row == 2 && col == 2) return _blueScale;
    if (row == 3 && col == 3) return 1;
    return 0;
  }

  void _setPreset(bool isLight) {
    setState(() {
      if (isLight) {
        _redScale = 1.1;
        _greenScale = 1.1;
        _blueScale = 1.1;
        _additive = 0.1;
        _blurSigma = 2.0;
      } else {
        _redScale = 0.8;
        _greenScale = 0.8;
        _blueScale = 0.9;
        _additive = -0.1;
        _blurSigma = 3.0;
      }
    });
  }
}

class DeviceFrameView extends StatefulWidget {
  const DeviceFrameView({super.key, required this.imageFilter});

  final ImageFilter imageFilter;

  @override
  _DeviceFrameViewState createState() => _DeviceFrameViewState();
}

class _DeviceFrameViewState extends State<DeviceFrameView> {
  final List<Color> colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      device: Devices.ios.iPhone13,
      screen: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ClipRect(
            child: BackdropFilter(
              filter: widget.imageFilter,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  'Colorful ListView',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: colors[index % colors.length],
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  'Item $index',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  'Description for item $index',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: colors[(index + 2) % colors.length],
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
