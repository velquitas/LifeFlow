import 'package:flutter/material.dart';

class TaskHeader extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  final int totalTasks;
  final int completedTasks;
  final int openTasks;
  final double completionRate;

  const TaskHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.totalTasks,
    required this.completedTasks,
    required this.openTasks,
    required this.completionRate,
  });

  Widget _statCard({
    required String value,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 12,
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: "Search tasks...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            _statCard(
              value: "$totalTasks",
              label: "Total",
              color: Colors.blue,
              icon: Icons.list_alt,
            ),

            const SizedBox(width: 12),

            _statCard(
              value: "$openTasks",
              label: "Open",
              color: Colors.orange,
              icon: Icons.pending_actions,
            ),

            const SizedBox(width: 12),

            _statCard(
              value: "$completedTasks",
              label: "Done",
              color: Colors.green,
              icon: Icons.check_circle,
            ),
          ],
        ),

        const SizedBox(height: 20),

        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: completionRate,
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}