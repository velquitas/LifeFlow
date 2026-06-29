
import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onDelete,
  });

  String get _priorityLabel {
    switch (task.priority) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
              onTap: onTap,
              onLongPress: () {},
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
            Text(task.category),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.flag, color: task.priorityColor, size: 16),
                const SizedBox(width: 4),
                Text(_priorityLabel),
                if (task.dueDate != null) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.schedule, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${task.dueDate!.month}/${task.dueDate!.day}/${task.dueDate!.year}",
                  ),
                ],
              ],
            ),
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
