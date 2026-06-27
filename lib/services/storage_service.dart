
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class StorageService {
  static const String _tasksKey = 'lifeflow_tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final data = tasks
        .map((task) => jsonEncode(task.toJson()))
        .toList();

    await prefs.setStringList(_tasksKey, data);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(_tasksKey);

    if (data == null) return [];

    return data
        .map(
          (item) => Task.fromJson(
            jsonDecode(item) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  static Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
  }
}
