import 'package:flutter/material.dart';

class InspirationCard extends StatelessWidget {
  const InspirationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome),
                SizedBox(width: 10),
                Text(
                  "Daily Inspiration",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "\"Small consistent actions create extraordinary lives.\"",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}