import 'package:a_closer_look_at_the_blur_effect/slides/slide_33_demo/demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:device_frame/device_frame.dart';

import 'package:flutter_shaders/flutter_shaders.dart';

class Slide33Demo extends FlutterDeckSlideWidget {
  const Slide33Demo()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/Slide33Demo',
            title: 'Slide33Demo',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return DeviceAnimationDemo();
      },
    );
  }
}

class DeviceAnimationDemo extends StatefulWidget {
  const DeviceAnimationDemo({Key? key}) : super(key: key);

  @override
  _DeviceAnimationDemoState createState() => _DeviceAnimationDemoState();
}

class _DeviceAnimationDemoState extends State<DeviceAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isIPhone = false;
  bool _isReverse = false;
  bool isNameDropAnimating = false;
  Duration nameDropDuration = const Duration(seconds: 4);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _animation.addListener(() {
      if (mounted) {
        setState(() {
          if (_animation.value == 1.0 && !isNameDropAnimating) {
            isNameDropAnimating = true;
            Future.delayed(nameDropDuration, () {
              setState(() {
                isNameDropAnimating = false;
                _controller.reverse();
              });
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      Future.delayed(const Duration(seconds: 2), () {
        _isReverse ? _controller.reverse() : _controller.reset();
      });
    } else {
      _controller.forward();
    }
  }

  void _resetAnimation() {
    _controller.reset();
    setState(() {
      isNameDropAnimating = false;
    });
  }

  void _toggleDevice() {
    setState(() {
      _isIPhone = !_isIPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(
                          -MediaQuery.of(context).size.width *
                              0.2 *
                              (1 - _animation.value),
                          0),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DeviceFrame(
                            device: _isIPhone
                                ? Devices.ios.iPhone13
                                : Devices.android.samsungGalaxyS20,
                            screen: buildNameDropIOS17(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(
                          MediaQuery.of(context).size.width *
                              0.2 *
                              (1 - _animation.value),
                          0),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: DeviceFrame(
                            device: _isIPhone
                                ? Devices.ios.iPhone13
                                : Devices.android.samsungGalaxyS20,
                            screen: buildNameDropIOS17(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _toggleAnimation,
                  child: Text('Toggle Animation'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetAnimation,
                  child: Text('Reset'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _toggleDevice,
                  child: Text(
                      _isIPhone ? 'Switch to Android' : 'Switch to iPhone'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameDropIOS17() {
    return MinuteChangeShaderEffect(
      duration: nameDropDuration,
      isAnimating: _isIPhone ? isNameDropAnimating : false,
      child: Theme(
        data: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF4F4F4F),
        ),
        child: TicketFoldDemo(),
      ),
    );
  }
}

class MinuteChangeShaderEffect extends StatefulWidget {
  const MinuteChangeShaderEffect({
    Key? key,
    required this.child,
    required this.isAnimating,
    required this.duration,
  }) : super(key: key);

  final Widget child;
  final bool isAnimating;
  final Duration duration;

  @override
  State<MinuteChangeShaderEffect> createState() =>
      _MinuteChangeShaderEffectState();
}

class _MinuteChangeShaderEffectState extends State<MinuteChangeShaderEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween(begin: 0.0, end: 2.0).animate(_controller)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

    _updateAnimationState();
  }

  @override
  void didUpdateWidget(MinuteChangeShaderEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAnimating != widget.isAnimating) {
      _updateAnimationState();
    }
  }

  void _updateAnimationState() async {
    if (widget.isAnimating && !_controller.isAnimating) {
      _controller.reset();
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        _controller.forward();
      }
    } else if (!widget.isAnimating && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      (context, shader, child) {
        return AnimatedSampler(
          (image, size, canvas) {
            shader.setFloat(0, size.width);
            shader.setFloat(1, size.height);
            shader.setFloat(2, _animation.value);
            shader.setImageSampler(0, image);
            canvas.drawRect(
              Rect.fromLTWH(0, 0, size.width, size.height),
              Paint()..shader = shader,
            );
          },
          child: widget.child,
        );
      },
      assetKey: 'shaders/name_drop.frag',
    );
  }
}
