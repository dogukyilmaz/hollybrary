// import "dart:ui";
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF1E1E1E);
  static const Color secondaryColor = Color(0xFF2E2E2E);
  static const Color accentColor = Color(0xFFE5E5E5);
  static const Color primaryTextColor = Color(0xFFE5E5E5);
  static const Color secondaryTextColor = Color(0xFF1E1E1E);
  static const Color accentTextColor = Color(0xFF2E2E2E);
  static const Color scaffoldColor = Color(0x00000000);
}

final TextStyle normalText = GoogleFonts.montserrat(
    textStyle: const TextStyle(fontSize: 16, letterSpacing: 0.8));

final TextStyle heading = GoogleFonts.montserrat(
  textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
);
