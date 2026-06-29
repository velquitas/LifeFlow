
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

  TaskPriority _selectedPriority = TaskPriority.medium;
  String _selectedCategory = "General";
  DateTime? _selectedDueDate;

  List<Task> get _filteredTasks {
    List<Task> filtered = List.from(_tasks);

    if (_filter == "Open") {
      filtered = filtered.where((t) => !t.completed).toList();
    }

    if (_filter == "Completed") {
      filtered = filtered.where((t) => t.completed).toList();
    }

    if (_search.text.isNotEmpty) {
      filtered = filtered.where((task) {
        return task.title
          .toLowerCase()
          .contains(_search.text.toLowerCase());
      }).toList();
    }

    filtered.sort((a, b) {
      if (a.completed == b.completed) {
        return a.title.compareTo(b.title);
      }
      return a.completed ? 1 : -1;
  });

  return filtered;
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

  Future<void> _showTaskDialog({Task? editingTask}) async {
    _controller.clear();

    _selectedCategory = "General";
    _selectedPriority = TaskPriority.medium;
    _selectedDueDate = null;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("New Task"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: "Task Title",
                      ),
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: "Category",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "General",
                          child: Text("General"),
                        ),
                        DropdownMenuItem(
                          value: "Work",
                          child: Text("Work"),
                        ),
                        DropdownMenuItem(
                          value: "Home",
                          child: Text("Home"),
                        ),
                        DropdownMenuItem(
                          value: "Health",
                          child: Text("Health"),
                        ),
                        DropdownMenuItem(
                          value: "Finance",
                          child: Text("Finance"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<TaskPriority>(
                      value: _selectedPriority,
                      decoration: const InputDecoration(
                        labelText: "Priority",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: TaskPriority.low,
                          child: Text("Low"),
                        ),
                        DropdownMenuItem(
                          value: TaskPriority.medium,
                          child: Text("Medium"),
                        ),
                        DropdownMenuItem(
                          value: TaskPriority.high,
                          child: Text("High"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          _selectedPriority = value;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _selectedDueDate == null
                          ? "Select Due Date"
                          : "${_selectedDueDate!.month}/${_selectedDueDate!.day}/${_selectedDueDate!.year}",
                      ),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: dialogContext,
                          initialDate:
                            _selectedDueDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (picked != null) {
                          setDialogState(() {
                            _selectedDueDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                FilledButton(
                  onPressed: () async {
                    if (_controller.text.trim().isEmpty) return;

                    setState(() {
                      _tasks.add(
                        Task(
                          id: DateTime.now()
                            .millisecondsSinceEpoch
                            .toString(),
                          title: _controller.text.trim(),
                          category: _selectedCategory,
                          priority: _selectedPriority,
                          dueDate: _selectedDueDate,
                        ),
                      );
                    });

                    await _saveTasks();

                    if (!mounted) return;

                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
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
        onPressed: () => _showTaskDialog(),
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
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(
              task: task,
              onTap: () {
                setState(() {
                  task.completed = !task.completed;
                });
                _saveTasks();
              },
              onEdit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Editing ${task.title} coming soon"),
                  ),
                );
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
