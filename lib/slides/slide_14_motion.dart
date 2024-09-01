import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'dart:ui';
import 'dart:async';
import 'package:device_frame/device_frame.dart';

class Slide14 extends FlutterDeckSlideWidget {
  const Slide14()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/14',
            title: '14',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const MotionBlurDemo();
      },
    );
  }
}

class MotionBlurDemo extends StatefulWidget {
  const MotionBlurDemo({super.key});

  @override
  _MotionBlurDemoState createState() => _MotionBlurDemoState();
}

class _MotionBlurDemoState extends State<MotionBlurDemo> {
  double _maxScrollSpeed = 10.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Motion Blur', style: TextStyles.title),
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            children: [
              // Left side: Demo
              Expanded(
                flex: 2,
                child: DeviceFrame(
                  device: Devices.ios.iPhone13,
                  screen: BlurredListViewDemo(maxScrollSpeed: _maxScrollSpeed),
                ),
              ),
              // Right side: Slider
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Max Scroll Speed', style: TextStyles.bodyText),
                      Slider(
                        value: _maxScrollSpeed,
                        min: 1.0,
                        max: 20.0,
                        divisions: 19,
                        label: _maxScrollSpeed.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _maxScrollSpeed = value;
                          });
                        },
                      ),
                      Text(_maxScrollSpeed.toStringAsFixed(1),
                          style: TextStyles.bodyText),
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

// class MotionBlurDemo extends StatelessWidget {
//   const MotionBlurDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var highlightedCode = highlighter.highlight("""
// AnimatedBuilder(
//   animation: _blurAnimation,
//   builder: (context, child) => IgnorePointer(
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaY: _blurAnimation.value),
//       child: Container(color: Colors.transparent),
//     ),
//   ),
// ),
// """);
//     return Column(
//       children: [
//         Text('Motion Blur', style: TextStyles.subtitle),
//         const SizedBox(height: 20),
//         Expanded(
//           child: Row(
//             children: [
//               // Left side: Demo
//               Expanded(
//                 child: DeviceFrame(
//                   device: Devices.ios.iPhone13,
//                   screen: BlurredListViewDemo(),
//                 ),
//               ),
//               // Right side: Code
//               Expanded(
//                 child: Container(
//                   color: Colors.grey[200],
//                   padding: EdgeInsets.all(16),
//                   child: SingleChildScrollView(
//                     child: Text.rich(highlightedCode),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class BlurredListViewDemo extends StatefulWidget {
  final double maxScrollSpeed;

  const BlurredListViewDemo({super.key, required this.maxScrollSpeed});

  @override
  _BlurredListViewDemoState createState() => _BlurredListViewDemoState();
}

class _BlurredListViewDemoState extends State<BlurredListViewDemo>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _blurAnimation;
  Timer? _scrollEndTimer;
  double _lastScrollPosition = 0;
  double _scrollSpeed = 0;
  DateTime _lastScrollTime = DateTime.now();
  double _maxScrollSpeed = 10.0; // Adjust this value to change blur sensitivity
  bool _isMotionBlurEnabled = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _blurAnimation =
        Tween<double>(begin: 0, end: 20).animate(_animationController);
  }

  void _scrollListener() {
    if (!_isMotionBlurEnabled) return;

    final currentScrollPosition = _scrollController.position.pixels;
    final currentTime = DateTime.now();
    final timeDiff = currentTime.difference(_lastScrollTime).inMilliseconds;

    if (timeDiff > 0) {
      _scrollSpeed =
          (currentScrollPosition - _lastScrollPosition).abs() / timeDiff;

      // Calculate blur amount based on scroll speed
      double blurAmount = (_scrollSpeed / _maxScrollSpeed).clamp(0.0, 1.0);
      _animationController.animateTo(blurAmount,
          duration: const Duration(milliseconds: 50));

      setState(() {});
    }

    _lastScrollPosition = currentScrollPosition;
    _lastScrollTime = currentTime;

    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(const Duration(milliseconds: 200), () {
      _animationController.animateTo(0, duration: const Duration(milliseconds: 200));
    });
  }

  @override
  Widget build(BuildContext context) {
    _maxScrollSpeed =
        widget.maxScrollSpeed; // Update maxScrollSpeed when it changes

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blurred ListView'),
        actions: [
          Text(_scrollSpeed.toStringAsFixed(2)),
          Switch(
            value: _isMotionBlurEnabled,
            onChanged: (value) {
              setState(() {
                _isMotionBlurEnabled = value;
                if (!_isMotionBlurEnabled) {
                  _animationController.animateTo(0);
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad
              },
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: 50,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(8),
                child: Image.network(
                  'https://picsum.photos/seed/${index + 1}/300/200',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (_isMotionBlurEnabled)
            AnimatedBuilder(
              animation: _blurAnimation,
              builder: (context, child) => IgnorePointer(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: _blurAnimation.value),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _scrollEndTimer?.cancel();
    super.dispose();
  }
}
