import 'planner_event.dart';
import 'task.dart';

class DashboardData {
  final List<Task> todaysTasks;
  final List<PlannerEvent> todaysEvents;

  final int totalTasks;
  final int completedTasks;
  final int openTasks;

  final double balance;
  final double income;
  final double expenses;

  DashboardData({
    required this.todaysTasks,
    required this.todaysEvents,
    required this.totalTasks,
    required this.completedTasks,
    required this.openTasks,
    required this.balance,
    required this.income,
    required this.expenses,
  });

  double get completionRate {
    if (totalTasks == 0) return 0;
    return completedTasks / totalTasks;
  }
}