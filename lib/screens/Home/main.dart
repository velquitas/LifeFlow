import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const LifeFlowApp());
}

class LifeFlowApp extends StatelessWidget {
  const LifeFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LifeFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7A9B82),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F5EE),
      ),
      home: const HomeScreen(),
    );
  }
}