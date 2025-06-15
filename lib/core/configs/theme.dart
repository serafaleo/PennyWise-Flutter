import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme(Brightness brightness) {
  final ThemeData baseTheme = ThemeData(
    brightness: brightness,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: brightness),
  );

  return baseTheme.copyWith(textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme));
}
