import 'package:flutter/material.dart';

abstract class Spacing {
  // Tiny spacing
  static const double xs = 4.0;

  // Small spacing
  static const double sm = 8.0;

  // Medium spacing
  static const double md = 16.0;

  // Large spacing
  static const double lg = 24.0;

  // Extra large spacing
  static const double xl = 32.0;

  // XXL spacing
  static const double xxl = 48.0;

  // Horizontal spacing
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);

  // Vertical spacing
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);

  // All-sides spacing
  static const EdgeInsets allXs = EdgeInsets.all(xs);
  static const EdgeInsets allSm = EdgeInsets.all(sm);
  static const EdgeInsets allMd = EdgeInsets.all(md);
  static const EdgeInsets allLg = EdgeInsets.all(lg);
  static const EdgeInsets allXl = EdgeInsets.all(xl);

  // Custom spacing helpers
  static EdgeInsets custom(
      {double? left, double? top, double? right, double? bottom}) {
    return EdgeInsets.only(
      left: left ?? 0,
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
    );
  }

  static Widget verticalSpacer(double height) => SizedBox(height: height);
  static Widget horizontalSpacer(double width) => SizedBox(width: width);
}
