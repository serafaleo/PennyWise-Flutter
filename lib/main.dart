import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pennywise/core/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PennyWise',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      routerConfig: router,
    );
  }

  ThemeData _buildTheme(brightness) {
    ThemeData baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan, brightness: brightness),
    );

    return baseTheme.copyWith(textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme));
  }
}
