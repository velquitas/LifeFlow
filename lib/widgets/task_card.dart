import 'package:flutter/material.dart';

import '../models/task.dart';
import '../models/task_category.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  String get _priorityLabel {
    switch (task.priority) {
      case TaskPriority.low:
        return "Low";
      case TaskPriority.medium:
        return "Medium";
      case TaskPriority.high:
        return "High";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onTap,
        onLongPress: onEdit,
        leading: Checkbox(
          value: task.completed,
          onChanged: (_) => onTap?.call(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: Icon(
                    task.category.icon,
                    size: 18,
                    color: task.category.color,
                  ),
                  label: Text(task.category.displayName),
                  backgroundColor:
                      task.category.color.withValues(alpha: 0.12),
                ),

                Chip(
                  avatar: Icon(
                    Icons.flag,
                    size: 18,
                    color: task.priorityColor,
                  ),
                  label: Text(_priorityLabel),
                  backgroundColor:
                      task.priorityColor.withValues(alpha: 0.12),
                ),
              ],
            ),

            if (task.dueDate != null) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${task.dueDate!.month}/${task.dueDate!.day}/${task.dueDate!.year}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: onDelete == null
            ? null
            : IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
              ),
      ),
    );
  }
}