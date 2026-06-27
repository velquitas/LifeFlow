import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF7A9B82),
      scaffoldBackgroundColor: Colors.grey.shade100,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFF7A9B82),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF7A9B82),
        foregroundColor: Colors.white,
      ),
    );
  }
}