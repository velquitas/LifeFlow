
import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

class Task {
  String id;
  String title;
  String category;
  DateTime? dueDate;
  TaskPriority priority;
  bool completed;

  Task({
    required this.id,
    required this.title,
    this.category = "General",
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.completed = false,
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
        "category": category,
        "dueDate": dueDate?.toIso8601String(),
        "priority": priority.index,
        "completed": completed,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        category: json["category"] ?? "General",
        dueDate: json["dueDate"] != null
            ? DateTime.parse(json["dueDate"])
            : null,
        priority: TaskPriority.values[json["priority"] ?? 1],
        completed: json["completed"] ?? false,
      );
}
