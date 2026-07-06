import 'package:flutter/material.dart';
import '../models/task_category.dart';
import '../models/task.dart';

class TodaysTasksCard extends StatelessWidget {
  final List<Task> tasks;
  final ValueChanged<Task> onToggle;

  const TodaysTasksCard({
    super.key,
    required this.tasks,
    required this.onToggle,
  });

  bool _isToday(DateTime? date) {
    if (date == null) return false;

    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final todayTasks = tasks
        .where(
          (task) =>
              !task.completed &&
              _isToday(task.dueDate),
        )
        .take(5)
        .toList();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.today),
                SizedBox(width: 8),
                Text(
                  "Today's Tasks",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (todayTasks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text(
                  "You're all caught up today! 🎉",
                ),
              )
            else
              ...todayTasks.map(
                (task) => CheckboxListTile(
                  dense: true,
                  value: task.completed,
                  title: Text(task.title),
                  subtitle: Text(
                    task.category.displayName,
                  ),
                  controlAffinity:
                      ListTileControlAffinity.leading,
                  onChanged: (_) => onToggle(task),
                ),
              ),
          ],
        ),
      ),
    );
  }
}