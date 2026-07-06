import '../models/task.dart';
import 'storage_service.dart';

class TaskService {
  static Future<List<Task>> loadTasks() async {
    return StorageService.loadTasks();
  }

  static Future<void> saveTasks(
    List<Task> tasks,
  ) async {
    await StorageService.saveTasks(tasks);
  }

  static Future<void> toggleTask(
    Task task,
  ) async {
    final tasks = await StorageService.loadTasks();

    final index =
        tasks.indexWhere((t) => t.id == task.id);

    if (index == -1) return;

    tasks[index].completed =
        !tasks[index].completed;

    await StorageService.saveTasks(tasks);
  }

  static Future<void> deleteTask(
    String id,
  ) async {
    final tasks = await StorageService.loadTasks();

    tasks.removeWhere((task) => task.id == id);

    await StorageService.saveTasks(tasks);
  }
}