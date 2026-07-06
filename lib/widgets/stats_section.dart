import 'package:flutter/material.dart';

import 'stat_card.dart';

class StatsSection extends StatelessWidget {
  final int totalTasks;
  final int openTasks;
  final int completedTasks;
  final double completionRate;

  const StatsSection({
    super.key,
    required this.totalTasks,
    required this.openTasks,
    required this.completedTasks,
    required this.completionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            StatCard(
              value: "$totalTasks",
              label: "Total",
              icon: Icons.list_alt,
              color: Colors.blue,
            ),
            const SizedBox(width: 12),
            StatCard(
              value: "$openTasks",
              label: "Open",
              icon: Icons.pending_actions,
              color: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            StatCard(
              value: "$completedTasks",
              label: "Done",
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(width: 12),
            StatCard(
              value: "${(completionRate * 100).toStringAsFixed(0)}%",
              label: "Progress",
              icon: Icons.trending_up,
              color: Colors.purple,
            ),
          ],
        ),
      ],
    );
  }
}