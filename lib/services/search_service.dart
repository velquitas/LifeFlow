import '../models/task.dart';
import '../models/planner_event.dart';
import '../models/task_category.dart';
class SearchService {
  static List<Task> searchTasks(
    List<Task> tasks,
    String query,
  ) {
    if (query.trim().isEmpty) return tasks;

    final search = query.toLowerCase();

    return tasks.where((task) {
      return task.title.toLowerCase().contains(search) ||
          task.category.displayName
              .toLowerCase()
              .contains(search);
    }).toList();
  }

  static List<PlannerEvent> searchEvents(
    List<PlannerEvent> events,
    String query,
  ) {
    if (query.trim().isEmpty) return events;

    final search = query.toLowerCase();

    return events.where((event) {
      return event.title.toLowerCase().contains(search);
    }).toList();
  }
}