import 'package:flutter/material.dart';

import '../models/planner_event.dart';

class TodaysEventsCard extends StatelessWidget {
  final List<PlannerEvent> events;

  const TodaysEventsCard({
    super.key,
    required this.events,
  });

  String _time(BuildContext context, PlannerEvent event) {
    if (event.allDay) {
      return "All Day";
    }

    final start = TimeOfDay.fromDateTime(
      event.start,
    ).format(context);

    final end = TimeOfDay.fromDateTime(
      event.end,
    ).format(context);

    return "$start • $end";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.calendar_today),
                SizedBox(width: 8),
                Text(
                  "Today's Events",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (events.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text(
                  "No events scheduled today.",
                ),
              )
            else
              ...events.take(5).map(
                (event) => ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.event,
                  ),
                  title: Text(event.title),
                  subtitle: Text(
                    _time(context, event),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}