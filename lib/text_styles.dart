import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  // Title style
  static TextStyle get title => GoogleFonts.roboto(
        fontSize: 62,
        color: Colors.white,
      );

  // Subtitle style
  static TextStyle get subtitle => GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      );

  // Body text style
  static TextStyle get bodyText => GoogleFonts.openSans(
        fontSize: 16,
        color: Colors.black87,
      );

  // Caption style
  static TextStyle get caption => GoogleFonts.roboto(
        fontSize: 14,
        fontStyle: FontStyle.italic,
        color: Colors.grey[600],
      );

  // Button text style
  static TextStyle get buttonText => GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  // Quote style
  static TextStyle get quote => GoogleFonts.merriweather(
        fontSize: 20,
        fontStyle: FontStyle.italic,
        color: Colors.black54,
      );
}
