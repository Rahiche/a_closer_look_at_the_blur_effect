import 'dart:ui';

import 'package:a_closer_look_at_the_blur_effect/slides/slide_0_into.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_1_problem.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_10_MaskFilter.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_11_ImageFilter.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_12_is_it_flexible.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_13_yes.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_14_motion.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_15_lens_like.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_16_saturated.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_17_Smooth.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_18_shadermask.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_19_not_enough.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_21_blur_with_dart.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_2_solution.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_20_interactive_blurring.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_22.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_23.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_24_gpu_vs_cpu.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_25_flutter_blur_code.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_26_not_all_blur_are_The_same.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_27_speedup_gaussian.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_28_fast_rrect.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_29_custom_ones.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_3_gauss.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_30_box_blur.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_31_lens.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_32_glassy.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_33_gradual.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_34_code_slides.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_35_thank_you.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_4.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_8_blur_apis.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_9_Shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

late Highlighter highlighter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Highlighter.initialize(['dart']);
  var theme = await HighlighterTheme.loadLightTheme();
  highlighter = Highlighter(
    language: 'dart',
    theme: theme,
  );
  runApp(const FlutterDeckExample());
}

class FlutterDeckExample extends StatelessWidget {
  const FlutterDeckExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: FlutterDeckApp(
        configuration: FlutterDeckConfiguration(
          slideSize: FlutterDeckSlideSize.fromAspectRatio(
            aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
            resolution: const FlutterDeckResolution.fhd(),
          ),
          showProgress: false,
          transition: const FlutterDeckTransition.custom(
            transitionBuilder: FlutterDeckVSlideTransitionBuilder(),
          ),
        ),
        darkTheme: FlutterDeckThemeData.fromTheme(
          ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF16222A),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
        ),
        slides: const [
          Slide0(),
          Slide1(),
          Slide2(),
          Slide3(),
          Slide4(),
          Slide8(),
          Slide9(),
          Slide10(),
          Slide11(),
          Slide12(),
          Slide13(),
          Slide14(),
          Slide15(),
          Slide16(),
          Slide17(),
          Slide18(),
          Slide19(),
          Slide20(),
          Slide21(),
          Slide22(),
          Slide23(),
          Slide24(),
          Slide25(),
          Slide26(),
          Slide27(),
          Slide28(),
          Slide29(),
          Slide30(),
          Slide31(),
          Slide32(),
          Slide33(),
          Slide34(),
          Slide35(),
        ],
        locale: const Locale('en'),
      ),
    );
  }
}

class FlutterDeckVSlideTransitionBuilder extends FlutterDeckTransitionBuilder {
  const FlutterDeckVSlideTransitionBuilder();

  @override
  Widget build(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
      // child: SlideTransition(
      //   position: animation.drive(
      //     Tween<Offset>(
      //       begin: const Offset(0, -1),
      //       end: Offset.zero,
      //     ).chain(CurveTween(curve: Curves.easeIn)),
      //   ),
      //   child: child,
      // ),
    );
  }
}
