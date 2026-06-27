
import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../../services/storage_service.dart';
import '../../widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _controller =
      TextEditingController();

  final TextEditingController _search =
      TextEditingController();

  List<Task> _tasks = [];

  String _filter = 'All';

  List<Task> get _filteredTasks {
    if (_search.text.isEmpty) {
      return _tasks;
    }

    return _tasks.where((task) {
      return task.title
        .toLowerCase()
        .contains(_search.text.toLowerCase());
    }).toList();
}

  int get totalTasks => _tasks.length;

  int get completedTasks =>
      _tasks.where((t) => t.completed).length;

  int get openTasks =>
      totalTasks - completedTasks;

  double get completionRate =>
    totalTasks == 0 ? 0 : completedTasks / totalTasks;

  @override
void initState() {
  super.initState();
  _loadTasks();
}

  Future<void> _loadTasks() async {
  final loaded = await StorageService.loadTasks();

  if (!mounted) return;

  setState(() {
    _tasks = loaded;
  });
}

  Future<void> _saveTasks() async {
  await StorageService.saveTasks(_tasks);
}

  Future<void> _addTask() async {
    _controller.clear();
    await showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Task title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(d),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (_controller.text.trim().isEmpty) return;
              setState(() {
                _tasks.add(
                  Task(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: _controller.text.trim(),
                  ),
                );
              });
              _saveTasks();
              Navigator.pop(d);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _filteredTasks;

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: "Search tasks...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
    ),
  ),
  onChanged: (_) {
    setState(() {});
  },
),

const SizedBox(height: 16),

SegmentedButton<String>(
  segments: const [
    ButtonSegment(
      value: 'All',
      label: Text('All'),
    ),
    ButtonSegment(
      value: 'Open',
      label: Text('Open'),
    ),
    ButtonSegment(
      value: 'Completed',
      label: Text('Done'),
    ),
  ],
  selected: {_filter},
  onSelectionChanged: (selection) {
    setState(() {
      _filter = selection.first;
    });
  },
),

const SizedBox(height: 20),
const SizedBox(height: 20),

Row(
  children: [
    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "$totalTasks",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text("Total"),
            ],
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "$completedTasks",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text("Done"),
            ],
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "$openTasks",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text("Open"),
            ],
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(height: 16),

LinearProgressIndicator(
  value: completionRate,
  minHeight: 8,
  borderRadius: BorderRadius.circular(8),
),

const SizedBox(height: 20),
              
  
Expanded(
  child: tasks.isEmpty
      ? const Center(child: Text('No tasks'))
      : ListView.builder(
          itemCount: _filteredTasks.length,
          itemBuilder: (context, index) {
            final task = _filteredTasks[index];
            return TaskCard(
              task: task,
              onTap: () {
                setState(() {
                  task.completed = !task.completed;
                });
                _saveTasks();
              },
              onDelete: () {
                setState(() {
                  _tasks.remove(task);
                });
                _saveTasks();
              },
            );
          },
        ),
      ),
    ],
  ),
),
);
}
}
