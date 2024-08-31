import 'dart:ui';

import 'package:a_closer_look_at_the_blur_effect/slides/slide_0_into.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_1_problem.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_10_MaskFilter.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_11_ImageFilter.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_12.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_13.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_14_motion.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_15_lens_like.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_16_saturated.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_17_Smooth.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_18_shadermask.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_19_not_enough.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_2_solution.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_20_interactive_blurring.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_21.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_22.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_23.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_24.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_25.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_26.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_27.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_28.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_29.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_3_gauss.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_30.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_31.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_32.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_33.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_34.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_35.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_4.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_5.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_6.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_7.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_8_blur_apis.dart';
import 'package:a_closer_look_at_the_blur_effect/slides/slide_9_Shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

late Highlighter highlighter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Highlighter.initialize(['dart', 'yaml', 'sql']);
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
    return FlutterDeckApp(
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
        Slide5(),
        Slide6(),
        Slide7(),
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
