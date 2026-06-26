import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final String habit;
  final bool complete;

  const HabitCard({
    super.key,
    required this.habit,
    required this.complete,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(habit),
      value: complete,
      onChanged: (_) {},
      activeColor: const Color(0xFF7A9B82),
    );
  }
}