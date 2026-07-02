import '../models/task.dart';
import 'storage_service.dart';

class DashboardService {
  DashboardService._();

  static Future<List<Task>> getTasks() async {
    return await StorageService.loadTasks();
  }

  static Future<int> getOpenTaskCount() async {
    final tasks = await StorageService.loadTasks();

    return tasks.where((task) => !task.completed).length;
  }
  static Future<int> getCompletedTaskCount() async {
    final tasks = await StorageService.loadTasks();

    return tasks.where((task) => task.completed).length;
  }

  static Future<int> getTotalTaskCount() async {
    final tasks = await StorageService.loadTasks();

    return tasks.length;
  }

  static Future<double> getTaskCompletionRate() async {
    final tasks = await StorageService.loadTasks();

    if (tasks.isEmpty) {
      return 0;
    }

    final completed =
      tasks.where((task) => task.completed).length;

    return completed / tasks.length;
  }
}