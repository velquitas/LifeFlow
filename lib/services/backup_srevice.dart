import 'dart:convert';

import '../models/app_backup.dart';
import '../services/storage_service.dart';
import '../services/planner_service.dart';
import '../services/budget_service.dart';

class BackupService {
  /// Export all app data to a JSON string.
  static Future<String> exportBackup() async {
    final tasks = await StorageService.loadTasks();
    final plannerEvents = await PlannerService.loadEvents();
    final transactions =
        await BudgetService.loadTransactions();

    final backup = AppBackup(
      tasks: tasks,
      plannerEvents: plannerEvents,
      transactions: transactions,
    );

    return jsonEncode(backup.toJson());
  }

  /// Import all app data from a JSON string.
  static Future<void> importBackup(
    String jsonString,
  ) async {
    final json = jsonDecode(jsonString);

    final backup = AppBackup.fromJson(json);

    await StorageService.saveTasks(
      backup.tasks,
    );

    await PlannerService.saveEvents(
      backup.plannerEvents,
    );

    await BudgetService.saveTransactions(
      backup.transactions,
    );
  }
}