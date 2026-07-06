import 'package:flutter/material.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              child: Icon(Icons.event),
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coming Up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "No upcoming events",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Your schedule is clear.",
                    style: TextStyle(
                      color: Colors.grey,
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