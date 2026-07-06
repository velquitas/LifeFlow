import 'package:flutter/material.dart';

import '../models/task_category.dart';

class CategoryChip extends StatelessWidget {
  final TaskCategory category;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = category.color;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
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
                category.icon,
                color: color,
              ),

              const SizedBox(height: 8),

              Text(
                category.displayName,
                textAlign: TextAlign.center,
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