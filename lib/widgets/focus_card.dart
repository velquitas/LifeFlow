import 'package:flutter/material.dart';

class FocusCard extends StatelessWidget {
  final int openTasks;
  final int completedTasks;

  const FocusCard({
    super.key,
    required this.openTasks,
    required this.completedTasks,
  });

  String get title {
    if (openTasks == 0 && completedTasks == 0) {
      return "Welcome to LifeFlow";
    }

    if (openTasks == 0) {
      return "Fantastic!";
    }

    return "Today's Focus";
  }

  String get message {
    if (openTasks == 0 && completedTasks == 0) {
      return "Create your first task to begin organizing your day.";
    }

    if (openTasks == 0) {
      return "Everything is complete today. Enjoy your day!";
    }

    if (openTasks == 1) {
      return "Only one task remains. You've got this!";
    }

    return "You have $openTasks tasks remaining. Let's make progress today.";
  }

  IconData get icon {
    if (openTasks == 0 && completedTasks == 0) {
      return Icons.waving_hand;
    }

    if (openTasks == 0) {
      return Icons.celebration;
    }

    return Icons.track_changes;
  }

  Color get color {
    if (openTasks == 0 && completedTasks == 0) {
      return Colors.blue;
    }

    if (openTasks == 0) {
      return Colors.green;
    }

    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(.12),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}