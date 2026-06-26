import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LifeFlow"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7A9B82),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const Text(
              "Good Morning 👋",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              DateTime.now().toString().substring(0,10),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              color: const Color(0xFFE8F1E7),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Today's Progress",
                      style: TextStyle(fontSize:20),
                    ),
                    SizedBox(height:15),
                    LinearProgressIndicator(
                      value: .66,
                      minHeight:10,
                    ),
                    SizedBox(height:10),
                    Text("2 of 3 Tasks Complete")
                  ],
                ),
              ),
            ),

            const SizedBox(height:25),

            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize:24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height:15),

            const TaskCard(
              title: "Grocery Shopping",
              priorityColor: Colors.red,
            ),

            const TaskCard(
              title: "Gym",
              priorityColor: Colors.orange,
            ),

            const TaskCard(
              title: "Finish LifeFlow",
              priorityColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}