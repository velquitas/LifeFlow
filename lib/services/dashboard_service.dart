import '../models/dashboard_data.dart';
import '../models/planner_event.dart';
import '../models/task.dart';
import '../models/transaction.dart';

import 'budget_service.dart';
import 'planner_service.dart';
import 'storage_service.dart';

class DashboardService {
  static Future<DashboardData> loadDashboard() async {
    final List<Task> tasks =
        await StorageService.loadTasks();

    final List<PlannerEvent> events =
        await PlannerService.loadEvents();

    final List<FinanceTransaction> transactions =
        await BudgetService.loadTransactions();

    final now = DateTime.now();

    final todaysTasks = tasks.where((task) {
      if (task.completed) return false;
      if (task.dueDate == null) return false;

      return task.dueDate!.year == now.year &&
          task.dueDate!.month == now.month &&
          task.dueDate!.day == now.day;
    }).toList();

    final todaysEvents = events.where((event) {
      return event.start.year == now.year &&
          event.start.month == now.month &&
          event.start.day == now.day;
    }).toList();

    final completed =
        tasks.where((task) => task.completed).length;

    return DashboardData(
      todaysTasks: todaysTasks,
      todaysEvents: todaysEvents,
      totalTasks: tasks.length,
      completedTasks: completed,
      openTasks: tasks.length - completed,
      balance: BudgetService.balance(transactions),
      income: BudgetService.totalIncome(transactions),
      expenses: BudgetService.totalExpenses(transactions),
    );
  }
}