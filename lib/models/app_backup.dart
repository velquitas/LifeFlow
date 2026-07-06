import 'task.dart';
import 'planner_event.dart';
import 'transaction.dart';

class AppBackup {
  final List<Task> tasks;
  final List<PlannerEvent> plannerEvents;
  final List<FinanceTransaction> transactions;

  AppBackup({
    required this.tasks,
    required this.plannerEvents,
    required this.transactions,
  });

  Map<String, dynamic> toJson() {
    return {
      "tasks": tasks.map((e) => e.toJson()).toList(),
      "plannerEvents":
          plannerEvents.map((e) => e.toJson()).toList(),
      "transactions":
          transactions.map((e) => e.toJson()).toList(),
    };
  }

  factory AppBackup.fromJson(Map<String, dynamic> json) {
    return AppBackup(
      tasks: (json["tasks"] as List)
          .map((e) => Task.fromJson(e))
          .toList(),

      plannerEvents:
          (json["plannerEvents"] as List)
              .map((e) => PlannerEvent.fromJson(e))
              .toList(),

      transactions:
          (json["transactions"] as List)
              .map((e) => FinanceTransaction.fromJson(e))
              .toList(),
    );
  }
}