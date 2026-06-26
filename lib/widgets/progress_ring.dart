import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress;

  const ProgressRing({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 130,
            height: 130,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              backgroundColor: Colors.grey.shade300,
              color: const Color(0xFF7A9B82),
            ),
          ),
          Text(
            "${(progress * 100).round()}%",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}