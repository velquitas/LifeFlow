import '../models/dashboard_summary.dart';
import '../models/task.dart';
import '../models/planner_event.dart';
import 'storage_service.dart';
import 'planner_service.dart';

class DashboardSummaryService {
  static Future<DashboardSummary> loadSummary() async {
    final List<Task> tasks = await StorageService.loadTasks();
    final List<PlannerEvent> events =
        await PlannerService.loadEvents();

    final now = DateTime.now();

    final dueToday = tasks.where((task) {
      if (task.dueDate == null) return false;

      return task.dueDate!.year == now.year &&
          task.dueDate!.month == now.month &&
          task.dueDate!.day == now.day;
    }).length;

    final todayEvents = events.where((event) {
      return event.start.year == now.year &&
          event.start.month == now.month &&
          event.start.day == now.day;
    }).length;

    final completed =
        tasks.where((task) => task.completed).length;

    return DashboardSummary(
      totalTasks: tasks.length,
      completedTasks: completed,
      openTasks: tasks.length - completed,
      dueToday: dueToday,
      todayEvents: todayEvents,
    );
  }
}