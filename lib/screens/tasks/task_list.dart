import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../../models/task_category.dart';
import '../../widgets/task_card.dart';
import '../../widgets/empty_tasks.dart';
import 'task_filter_bar.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final TaskFilter filter;
  final TaskCategory? category;

  final void Function(Task) onToggle;
  final void Function(Task) onEdit;
  final void Function(Task) onDelete;
  final VoidCallback onAddTask;

  const TaskList({
    super.key,
    required this.tasks,
    required this.filter,
    required this.category,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onAddTask,
  });

  List<Task> get _filteredTasks {
    var list = List<Task>.from(tasks);

    switch (filter) {
      case TaskFilter.open:
        list = list.where((t) => !t.completed).toList();
        break;

      case TaskFilter.completed:
        list = list.where((t) => t.completed).toList();
        break;

      case TaskFilter.all:
        break;
    }

    if (category != null) {
      list = list.where((t) => t.category == category).toList();
    }

    list.sort((a, b) {
      if (a.dueDate == null && b.dueDate == null) return 0;
      if (a.dueDate == null) return 1;
      if (b.dueDate == null) return -1;
      return a.dueDate!.compareTo(b.dueDate!);
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredTasks;

    if (items.isEmpty) {
      return EmptyTasks(
        onAddTask: onAddTask,
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final task = items[index];

        return Dismissible(
          key: ValueKey(task.id),

          background: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),

          secondaryBackground: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),

          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              onToggle(task);
              return false;
            }

            return true;
          },

          onDismissed: (_) {
            onDelete(task);
          },

          child: TaskCard(
            task: task,
            onTap: () => onToggle(task),
            onEdit: () => onEdit(task),
            onDelete: () => onDelete(task),
          ),
        );
      },
    );
  }
}