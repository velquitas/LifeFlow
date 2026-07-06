import 'package:flutter/material.dart';

import 'task_category.dart';
import 'task_repeat.dart';

enum TaskPriority {
  low,
  medium,
  high,
}

class Task {
  String id;
  String title;
  TaskCategory category;
  DateTime? dueDate;
  TaskPriority priority;
  bool completed;
  TaskRepeat repeat;

  Task({
    required this.id,
    required this.title,
    this.category = TaskCategory.personal,
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.completed = false,
    this.repeat = TaskRepeat.never,
  });

  Color get priorityColor {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category.name,
        "dueDate": dueDate?.toIso8601String(),
        "priority": priority.index,
        "completed": completed,
        "repeat": repeat.index,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        category: TaskCategory.values.firstWhere(
          (e) => e.name == (json["category"] ?? "personal"),
          orElse: () => TaskCategory.personal,
        ),
        dueDate: json["dueDate"] != null
            ? DateTime.parse(json["dueDate"])
            : null,
        priority: TaskPriority.values[json["priority"] ?? 1],
        completed: json["completed"] ?? false,
        repeat: TaskRepeat.values[json["repeat"] ?? 0],
      );
}