import 'package:flutter/material.dart';

import '../models/dashboard_summary.dart';

class DashboardSummaryCard extends StatelessWidget {
  final DashboardSummary summary;

  const DashboardSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Snapshot",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _item(
                  Icons.check_circle,
                  "${summary.totalTasks}",
                  "Tasks",
                  Colors.blue,
                ),
                _item(
                  Icons.today,
                  "${summary.dueToday}",
                  "Due Today",
                  Colors.orange,
                ),
                _item(
                  Icons.event,
                  "${summary.todayEvents}",
                  "Events",
                  Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }
}