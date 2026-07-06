import 'package:flutter/material.dart';

class TaskStats extends StatelessWidget {
  final int total;
  final int completed;
  final int open;

  const TaskStats({
    super.key,
    required this.total,
    required this.completed,
    required this.open,
  });

  Widget _statTile({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Card(
        elevation: 1,
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
                radius: 20,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
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
    return Row(
      children: [
        _statTile(
          label: "Total",
          value: total.toString(),
          color: Colors.blue,
          icon: Icons.list_alt,
        ),
        const SizedBox(width: 12),
        _statTile(
          label: "Open",
          value: open.toString(),
          color: Colors.orange,
          icon: Icons.pending_actions,
        ),
        const SizedBox(width: 12),
        _statTile(
          label: "Done",
          value: completed.toString(),
          color: Colors.green,
          icon: Icons.check_circle,
        ),
      ],
    );
  }
}