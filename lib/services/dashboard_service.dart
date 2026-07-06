import '../models/task.dart';
import '../models/planner_event.dart';
import '../models/transaction.dart';

import 'storage_service.dart';
import 'planner_service.dart';
import 'budget_service.dart';

class DashboardService {
  static Future<List<Task>> todaysTasks() async {
    final tasks = await StorageService.loadTasks();

    final now = DateTime.now();

    return tasks.where((task) {
      if (task.completed) return false;
      if (task.dueDate == null) return false;

      return task.dueDate!.year == now.year &&
          task.dueDate!.month == now.month &&
          task.dueDate!.day == now.day;
    }).toList();
  }

  static Future<List<PlannerEvent>> todaysEvents() async {
    final events = await PlannerService.loadEvents();

    final now = DateTime.now();

    return events.where((event) {
      return event.start.year == now.year &&
          event.start.month == now.month &&
          event.start.day == now.day;
    }).toList();
  }

  static Future<double> currentBalance() async {
    final transactions =
        await BudgetService.loadTransactions();

    return BudgetService.balance(transactions);
  }

  static Future<double> totalIncome() async {
    final transactions =
        await BudgetService.loadTransactions();

    return BudgetService.totalIncome(transactions);
  }

  static Future<double> totalExpenses() async {
    final transactions =
        await BudgetService.loadTransactions();

    return BudgetService.totalExpenses(transactions);
  }
}