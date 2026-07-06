import 'package:flutter/material.dart';

class DashboardSummaryCard extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;
  final int openTasks;

  const DashboardSummaryCard({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    required this.openTasks,
  });

  Widget _stat(
    String label,
    int value,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _stat(
              "Total",
              totalTasks,
              Colors.blue,
            ),
            _stat(
              "Open",
              openTasks,
              Colors.orange,
            ),
            _stat(
              "Done",
              completedTasks,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}