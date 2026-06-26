import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final Color priorityColor;
  final bool completed;

  const TaskCard({
    super.key,
    required this.title,
    required this.priorityColor,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 7,
          backgroundColor: priorityColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            decoration:
                completed ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          completed
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          color: completed ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}