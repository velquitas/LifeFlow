import 'package:flutter/material.dart';

class Task {
  String title;
  Color priorityColor;
  bool isCompleted;

  Task({
    required this.title,
    required this.priorityColor,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'priorityColor': priorityColor.toARGB32(),
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      priorityColor: Color(json['priorityColor']),
      isCompleted: json['isCompleted'],
    );
  }
}