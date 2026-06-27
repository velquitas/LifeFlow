import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final Color priorityColor;
  final bool isCompleted;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.priorityColor,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 8,
          backgroundColor: priorityColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration:
                isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (_) => onTap(),
        ),
      ),
    );
  }
}