import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Slide4 extends FlutterDeckSlideWidget {
  const Slide4()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/4',
            title: '4',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return Center(
          child: Column(
            children: [
              Text(
                'Back to the 20th century',
                style: TextStyles.title,
              ),
              Expanded(
                child: SizedBox(
                    width: 450, child: InteractiveMoneySavingExpertCard()),
              )
            ],
          ),
        );
      },
    );
  }
}

class MoneySavingExpertCard extends StatelessWidget {
  final bool useShader;

  const MoneySavingExpertCard({Key? key, this.useShader = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child: useShader
                            ? ShaderBuilder(
                                (context, shader, child) {
                                  return AnimatedSampler(
                                    (image, size, canvas) {
                                      shader.setFloat(0, size.width);
                                      shader.setFloat(1, size.height);
                                      shader.setImageSampler(0, image);

                                      canvas.drawRect(
                                        Rect.fromLTWH(
                                          0,
                                          0,
                                          size.width,
                                          size.height,
                                        ),
                                        Paint()..shader = shader,
                                      );
                                    },
                                    child: Image.network(
                                      'https://i.imgur.com/RVtgjxP.png',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                assetKey: 'shaders/tilt_shift_gaussian.frag',
                              )
                            : Image.network(
                                'https://i.imgur.com/RVtgjxP.png',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'PRO TIP',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Save money with Martin Lewis's app",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'The Money Saving Expert talks tackling your finances.',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        // Handle close button press
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You know Martin Lewis best as the Money Saving Expert, who many of us rely on for trusted information on financial issues.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '"Companies spend billions of pounds a year on advertising, marketing and teaching their staff to sell, but we, as consumers, never get any buyers\' training," explains Lewis.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This is why he made it his "life\'s work" to help everyone be better with money –',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InteractiveMoneySavingExpertCard extends StatefulWidget {
  @override
  _InteractiveMoneySavingExpertCardState createState() =>
      _InteractiveMoneySavingExpertCardState();
}

class _InteractiveMoneySavingExpertCardState
    extends State<InteractiveMoneySavingExpertCard>
    with SingleTickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  static const double _minScale = 1.0;
  static const double _maxScale = 4.0;
  double _currentScale = 1.0;
  bool _useShader = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateTransform(Matrix4 end) {
    _animation = Matrix4Tween(
      begin: _controller.value,
      end: end,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward(from: 0);
  }

  void _incrementScale(double increment) {
    final newScale = (_currentScale + increment).clamp(_minScale, _maxScale);
    final matrix = Matrix4.identity()..scale(newScale);
    _currentScale = newScale;
    _animateTransform(matrix);
  }

  void scaleAndTransform(double scale, Offset focalPoint) {
    final double newScale = scale.clamp(_minScale, _maxScale);

    final Matrix4 matrix = Matrix4.identity()
      ..translate(focalPoint.dx, focalPoint.dy)
      ..scale(newScale)
      ..translate(-focalPoint.dx, -focalPoint.dy);

    _currentScale = newScale;
    _animateTransform(matrix);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return InteractiveViewer(
              transformationController: _controller,
              minScale: _minScale,
              maxScale: _maxScale,
              child: Transform(
                transform: _animation?.value ?? Matrix4.identity(),
                child: MoneySavingExpertCard(useShader: _useShader),
              ),
            );
          },
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "1",
                  mini: true,
                  child: Icon(Icons.add),
                  onPressed: () => _incrementScale(0.5),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  heroTag: "2",
                  mini: true,
                  child: Icon(Icons.remove),
                  onPressed: () => _incrementScale(-0.5),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  heroTag: "3",
                  mini: true,
                  child: Icon(Icons.track_changes),
                  onPressed: () => scaleAndTransform(4.5, Offset(100, 200)),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  heroTag: "4",
                  mini: true,
                  child: Icon(Icons.refresh),
                  onPressed: () => scaleAndTransform(1.0, Offset(0, 0)),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Text('Blur:', style: TextStyle(color: Colors.white)),
                    Switch(
                      value: _useShader,
                      onChanged: (value) {
                        setState(() {
                          _useShader = value;
                        });
                      },
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
}
