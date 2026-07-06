import 'package:flutter/material.dart';

import '../../models/task_category.dart';

enum TaskFilter {
  all,
  open,
  completed,
}

class TaskFilterBar extends StatelessWidget {
  final TaskFilter filter;
  final TaskCategory? category;
  final ValueChanged<TaskFilter> onFilterChanged;
  final ValueChanged<TaskCategory?> onCategoryChanged;

  const TaskFilterBar({
    super.key,
    required this.filter,
    required this.category,
    required this.onFilterChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<TaskFilter>(
          segments: const [
            ButtonSegment(
              value: TaskFilter.all,
              label: Text("All"),
              icon: Icon(Icons.list),
            ),
            ButtonSegment(
              value: TaskFilter.open,
              label: Text("Open"),
              icon: Icon(Icons.pending_actions),
            ),
            ButtonSegment(
              value: TaskFilter.completed,
              label: Text("Done"),
              icon: Icon(Icons.check_circle),
            ),
          ],
          selected: {filter},
          onSelectionChanged: (selection) {
            onFilterChanged(selection.first);
          },
        ),

        const SizedBox(height: 16),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text("All"),
                selected: category == null,
                onSelected: (_) => onCategoryChanged(null),
              ),

              const SizedBox(width: 8),

              ...TaskCategory.values.map(
                (cat) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    avatar: Icon(
                      cat.icon,
                      size: 18,
                      color: cat.color,
                    ),
                    label: Text(cat.displayName),
                    selected: category == cat,
                    onSelected: (_) => onCategoryChanged(cat),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}