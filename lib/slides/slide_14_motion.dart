import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'dart:ui';
import 'dart:async';
import 'package:device_frame/device_frame.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

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
                child: BlurredListViewDemo(maxScrollSpeed: _maxScrollSpeed),
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
        const SizedBox(height: 80),
      ],
    );
  }
}

class BlurredListViewDemo extends StatefulWidget {
  final double maxScrollSpeed;

  const BlurredListViewDemo({Key? key, required this.maxScrollSpeed})
      : super(key: key);

  @override
  _BlurredListViewDemoState createState() => _BlurredListViewDemoState();
}

class _BlurredListViewDemoState extends State<BlurredListViewDemo>
    with SingleTickerProviderStateMixin {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late AnimationController _animationController;
  late Animation<double> _blurAnimation;
  Timer? _scrollEndTimer;
  double _lastScrollPosition = 0;
  double _scrollSpeed = 0;
  DateTime _lastScrollTime = DateTime.now();
  double _maxScrollSpeed = 10.0;
  bool _isMotionBlurEnabled = true;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _scrollController1 = _controllers.addAndGet();
    _scrollController2 = _controllers.addAndGet();
    _scrollController1.addListener(_scrollListener);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _blurAnimation =
        Tween<double>(begin: 0, end: 20).animate(_animationController);
  }

  void _scrollListener() {
    if (!_isMotionBlurEnabled) return;

    final currentScrollPosition = _scrollController1.position.pixels;
    final currentTime = DateTime.now();
    final timeDiff = currentTime.difference(_lastScrollTime).inMilliseconds;

    if (timeDiff > 0) {
      _scrollSpeed =
          (currentScrollPosition - _lastScrollPosition).abs() / timeDiff;
      double blurAmount = (_scrollSpeed / _maxScrollSpeed).clamp(0.0, 1.0);
      _animationController.animateTo(blurAmount,
          duration: const Duration(milliseconds: 50));
      setState(() {});
    }

    _lastScrollPosition = currentScrollPosition;
    _lastScrollTime = currentTime;

    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(const Duration(milliseconds: 200), () {
      _animationController.animateTo(0,
          duration: const Duration(milliseconds: 200));
    });
  }

  void _simulateFastScroll() {
    final targetPosition = _scrollController1.offset + 4500;
    _scrollController1.animateTo(
      targetPosition,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _goBack() {
    final targetPosition = 0.0;
    _scrollController1.animateTo(
      targetPosition,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildListView(ScrollController controller) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad
        },
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemCount: 500,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(8),
          child: CachedNetworkImage(
            imageUrl: 'https://picsum.photos/id/${index + 1}/600/400',
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _maxScrollSpeed = widget.maxScrollSpeed;

    return Row(
      children: [
        Expanded(
          child: DeviceFrame(
            device: Devices.ios.iPhone13,
            screen: Scaffold(
              appBar: AppBar(
                title: const Text('ListView'),
              ),
              body: Stack(
                children: [
                  _buildListView(_scrollController2),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: DeviceFrame(
            device: Devices.ios.iPhone13,
            screen: Scaffold(
              appBar: AppBar(
                title: const Text('Motion Blurred ListView'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.reset_tv),
                    onPressed: _goBack,
                    tooltip: 'goBack',
                  ),
                  IconButton(
                    icon: const Icon(Icons.speed),
                    onPressed: _simulateFastScroll,
                    tooltip: 'Simulate Fast Scroll',
                  ),
                ],
              ),
              body: Stack(
                children: [
                  _buildListView(_scrollController1),
                  if (_isMotionBlurEnabled)
                    AnimatedBuilder(
                      animation: _blurAnimation,
                      builder: (context, child) => IgnorePointer(
                        child: BackdropFilter(
                          filter:
                              ImageFilter.blur(sigmaY: _blurAnimation.value),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _animationController.dispose();
    _scrollEndTimer?.cancel();
    super.dispose();
  }
}
