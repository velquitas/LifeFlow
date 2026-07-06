import 'package:flutter/material.dart';

import '../models/task.dart';

class PriorityChip extends StatelessWidget {
  final TaskPriority priority;
  final bool selected;
  final VoidCallback onTap;

  const PriorityChip({
    super.key,
    required this.priority,
    required this.selected,
    required this.onTap,
  });

  String get label {
    switch (priority) {
      case TaskPriority.low:
        return "Low";
      case TaskPriority.medium:
        return "Medium";
      case TaskPriority.high:
        return "High";
    }
  }

  Color get color {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (priority) {
      case TaskPriority.low:
        return Icons.keyboard_arrow_down;
      case TaskPriority.medium:
        return Icons.remove;
      case TaskPriority.high:
        return Icons.priority_high;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: selected
                ? color.withValues(alpha: 0.15)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? color
                  : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}