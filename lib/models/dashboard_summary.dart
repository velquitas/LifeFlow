class DashboardSummary {
  final int totalTasks;
  final int completedTasks;
  final int openTasks;
  final int dueToday;
  final int todayEvents;

  const DashboardSummary({
    required this.totalTasks,
    required this.completedTasks,
    required this.openTasks,
    required this.dueToday,
    required this.todayEvents,
  });

  double get completionRate {
    if (totalTasks == 0) return 0;
    return completedTasks / totalTasks;
  }
}