import 'package:flutter/material.dart';

class EmptyTasks extends StatelessWidget {
  final VoidCallback onAddTask;

  const EmptyTasks({
    super.key,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.checklist_rounded,
              size: 90,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 24),

            const Text(
              "No Tasks Yet",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Create your first task and start organizing your day.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            FilledButton.icon(
              onPressed: onAddTask,
              icon: const Icon(Icons.add),
              label: const Text("Create First Task"),
              style: FilledButton.styleFrom(
                minimumSize: const Size(220, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}