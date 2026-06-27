import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final Color? color;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ringColor = color ?? Theme.of(context).colorScheme.primary;
    final clamped = progress.clamp(0.0, 1.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: clamped),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey.shade300,
                  color: ringColor,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(value * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Complete'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
