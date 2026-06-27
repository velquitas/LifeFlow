import 'package:flutter/material.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planner"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 24),

          Card(
            child: ListTile(
              leading: Icon(Icons.work),
              title: Text("Work"),
              subtitle: Text("8:00 AM - 4:00 PM"),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text("Workout"),
              subtitle: Text("5:30 PM"),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.restaurant),
              title: Text("Dinner"),
              subtitle: Text("6:30 PM"),
            ),
          ),
        ],
      ),
    );
  }
}