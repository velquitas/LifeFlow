import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/navigation/navigation_screen.dart';

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
      theme: AppTheme.lightTheme,
      home: const NavigationScreen(),
    );
  }
}