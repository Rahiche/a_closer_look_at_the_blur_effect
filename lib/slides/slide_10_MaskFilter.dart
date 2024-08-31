import 'package:a_closer_look_at_the_blur_effect/spacing.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'dart:ui';

class Slide10 extends FlutterDeckSlideWidget {
  const Slide10()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/10',
            title: '10',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return MaskFilterPlaygroundSlide();
      },
    );
  }
}

class MaskFilterPlaygroundSlide extends StatefulWidget {
  const MaskFilterPlaygroundSlide({super.key});

  @override
  _MaskFilterPlaygroundSlideState createState() =>
      _MaskFilterPlaygroundSlideState();
}

class _MaskFilterPlaygroundSlideState extends State<MaskFilterPlaygroundSlide> {
  MaskFilter? _currentFilter;
  double _blurRadius = 5.0;
  BlurStyle _blurStyle = BlurStyle.normal;
  Color _shapeColor = Colors.blue;
  Color _blurColor = Colors.black.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('MaskFilter Playground', style: TextStyles.subtitle),
        SizedBox(height: 20),
        Expanded(
          child: Row(
            children: [
              // Left side: Result view
              Expanded(
                flex: 3,
                child: Center(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShapeWithMask(
                          shape: ShapeType.circle,
                          color: _shapeColor,
                          blurColor: _blurColor,
                          maskFilter: _currentFilter),
                      ShapeWithMask(
                          shape: ShapeType.square,
                          color: _shapeColor,
                          blurColor: _blurColor,
                          maskFilter: _currentFilter),
                      ShapeWithMask(
                          shape: ShapeType.triangle,
                          color: _shapeColor,
                          blurColor: _blurColor,
                          maskFilter: _currentFilter),
                    ],
                  ),
                ),
              ),
              // Right side: Controls
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Blur Radius'),
                      Slider(
                        value: _blurRadius,
                        min: 0,
                        max: 20,
                        divisions: 20,
                        label: _blurRadius.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() {
                            _blurRadius = value;
                            _updateMaskFilter();
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Blur Style'),
                      Wrap(
                        children: BlurStyle.values.map((BlurStyle style) {
                          return RadioListTile<BlurStyle>(
                            title: Text(style.toString().split('.').last),
                            value: style,
                            groupValue: _blurStyle,
                            onChanged: (BlurStyle? value) {
                              setState(() {
                                _blurStyle = value!;
                                _updateMaskFilter();
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                      Text('Color'),
                      Wrap(
                        children: [
                          ColorOption(Colors.blue, _shapeColor,
                              onTap: () => _updateColor(Colors.blue)),
                          ColorOption(Colors.red, _shapeColor,
                              onTap: () => _updateColor(Colors.red)),
                          ColorOption(Colors.green, _shapeColor,
                              onTap: () => _updateColor(Colors.green)),
                          ColorOption(Colors.yellow, _shapeColor,
                              onTap: () => _updateColor(Colors.yellow)),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentFilter = null;
                          });
                        },
                        child: Text('Clear Filter'),
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

  void _updateMaskFilter() {
    setState(() {
      _currentFilter = MaskFilter.blur(_blurStyle, _blurRadius);
    });
  }

  void _updateColor(Color color) {
    setState(() {
      _shapeColor = color;
    });
  }
}

class MaskFilterPainter extends CustomPainter {
  final MaskFilter? maskFilter;
  final Color color;
  final Color blurColor;
  final ShapeType shapeType;

  MaskFilterPainter(
    this.maskFilter,
    this.color,
    this.blurColor,
    this.shapeType,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..maskFilter = maskFilter;

    switch (shapeType) {
      case ShapeType.circle:
        canvas.drawCircle(
            Offset(size.width / 2, size.height / 2), size.width / 2, paint);
        break;
      case ShapeType.square:
        canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
        break;
      case ShapeType.triangle:
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ShapeWithMask extends StatelessWidget {
  final ShapeType shape;
  final Color color;
  final Color blurColor;
  final MaskFilter? maskFilter;

  const ShapeWithMask({
    super.key,
    required this.shape,
    required this.color,
    required this.blurColor,
    this.maskFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.xl),
            child: Container(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: MaskFilterPainter(maskFilter, color, blurColor, shape),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ShapeType { circle, square, triangle }

class ColorOption extends StatelessWidget {
  final Color color;
  final Color selectedColor;
  final VoidCallback onTap;

  const ColorOption(this.color, this.selectedColor,
      {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: color == selectedColor ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
