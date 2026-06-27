
import 'package:flutter/material.dart';
import '../../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [
    Task(id: '1', title: 'Grocery Shopping', priority: TaskPriority.high),
    Task(id: '2', title: 'Gym', priority: TaskPriority.medium),
    Task(id: '3', title: 'Finish LifeFlow', priority: TaskPriority.low),
  ];

  double get progress =>
      tasks.isEmpty ? 0 : tasks.where((t) => t.completed).length / tasks.length;

  Future<void> _addTask() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(d), child: const Text('Cancel')),
          FilledButton(
            onPressed: (){
              if(controller.text.trim().isEmpty) return;
              setState(() {
                tasks.add(Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: controller.text.trim(),
                ));
              });
              Navigator.pop(d);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completed = tasks.where((t)=>t.completed).length;
    return Scaffold(
      appBar: AppBar(title: const Text('LifeFlow')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Welcome Back',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          const SizedBox(height:20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children:[
                const Text("Today's Progress"),
                const SizedBox(height:12),
                LinearProgressIndicator(value: progress),
                const SizedBox(height:12),
                Text('$completed of ${tasks.length} tasks complete'),
              ]),
            ),
          ),
          const SizedBox(height:20),
          ...tasks.map((task)=>Card(
            child: CheckboxListTile(
              value: task.completed,
              onChanged: (_){
                setState(()=>task.completed=!task.completed);
              },
              title: Text(task.title),
              subtitle: Text(task.category),
              secondary: CircleAvatar(backgroundColor: task.priorityColor),
            ),
          ))
        ],
      ),
    );
  }
}
