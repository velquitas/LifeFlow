import '../models/task.dart';
import '../models/task_repeat.dart';

class RecurringTaskService {
  static Task? generateNext(Task task) {
    if (task.repeat == TaskRepeat.never) {
      return null;
    }

    if (task.dueDate == null) {
      return null;
    }

    DateTime nextDate = task.dueDate!;

    switch (task.repeat) {
      case TaskRepeat.daily:
        nextDate = nextDate.add(const Duration(days: 1));
        break;

      case TaskRepeat.weekly:
        nextDate = nextDate.add(const Duration(days: 7));
        break;

      case TaskRepeat.monthly:
        nextDate = DateTime(
          nextDate.year,
          nextDate.month + 1,
          nextDate.day,
        );
        break;

      case TaskRepeat.yearly:
        nextDate = DateTime(
          nextDate.year + 1,
          nextDate.month,
          nextDate.day,
        );
        break;

      case TaskRepeat.never:
        return null;
    }

    return Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: task.title,
      category: task.category,
      priority: task.priority,
      dueDate: nextDate,
      repeat: task.repeat,
      completed: false,
    );
  }
}