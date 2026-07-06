import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String greeting;

  const DashboardHeader({
    super.key,
    required this.greeting,
  });

  String get _formattedDate {
    final now = DateTime.now();

    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    const weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    return "${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formattedDate,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: 0.12),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
