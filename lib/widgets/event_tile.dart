
import 'package:flutter/material.dart';

import '../models/event.dart';

class EventTile extends StatelessWidget {
  final PlannerEvent event;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const EventTile({
    super.key,
    required this.event,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.event),
        ),
        title: Text(
          event.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${event.date.month}/${event.date.day}/${event.date.year}",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
