
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
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _search = TextEditingController();

  List<Task> _tasks = [];
  String _filter = 'All';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final tasks = await StorageService.loadTasks();
    if (!mounted) return;
    setState(() => _tasks = tasks);
  }

  Future<void> _save() => StorageService.saveTasks(_tasks);

  List<Task> get _visible {
    final q = _search.text.toLowerCase();
    return _tasks.where((t) {
      if (_filter == 'Open' && t.completed) return false;
      if (_filter == 'Completed' && !t.completed) return false;
      return t.title.toLowerCase().contains(q);
    }).toList();
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
              _save();
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
    final tasks = _visible;

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
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search tasks',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'All', label: Text('All')),
                ButtonSegment(value: 'Open', label: Text('Open')),
                ButtonSegment(value: 'Completed', label: Text('Done')),
              ],
              selected: {_filter},
              onSelectionChanged: (s) {
                setState(() => _filter = s.first);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text('No tasks'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return TaskCard(
                          task: task,
                          onTap: () {
                            setState(() {
                              task.completed = !task.completed;
                            });
                            _save();
                          },
                          onDelete: () {
                            setState(() {
                              _tasks.remove(task);
                            });
                            _save();
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
