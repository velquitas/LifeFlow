
import 'package:flutter/material.dart';
import '../../models/task_category.dart';
import '../../models/task.dart';
import '../../services/storage_service.dart';
import '../../widgets/task_card.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/priority_chip.dart';
import 'task_header.dart';
import 'task_list.dart';
import 'task_filter_bar.dart';
import 'task_dialog.dart';
import '../../services/recurring_task_service.dart';

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
  TaskCategory _selectedCategory = TaskCategory.personal;
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

   _selectedCategory = TaskCategory.personal;
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

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        CategoryChip(
                          category: TaskCategory.personal,
                          selected: _selectedCategory == TaskCategory.personal,
                          onTap: () {
                            setDialogState(() {
                              _selectedCategory = TaskCategory.personal;
                            });
                          },
                        ),

                        const SizedBox(width: 12),

                        CategoryChip(
                          category: TaskCategory.work,
                          selected: _selectedCategory == TaskCategory.work,
                          onTap: () {
                            setDialogState(() {
                              _selectedCategory = TaskCategory.work;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        CategoryChip(
                          category: TaskCategory.home,
                          selected: _selectedCategory == TaskCategory.home,
                          onTap: () {
                          setDialogState(() {
                            _selectedCategory = TaskCategory.home;
                          });
                        },
                      ),

                      const SizedBox(width: 12),

                      CategoryChip(
                        category: TaskCategory.health,
                        selected: _selectedCategory == TaskCategory.health,
                        onTap: () {
                          setDialogState(() {
                            _selectedCategory = TaskCategory.health;
                          });
                        },
                      ),
                    ],
                  ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          CategoryChip(
                            category: TaskCategory.shopping,
                            selected: _selectedCategory == TaskCategory.shopping,
                            onTap: () {
                              setDialogState(() {
                                _selectedCategory = TaskCategory.shopping;
                              });
                            },
                          ),

                      const SizedBox(width: 12),

                      CategoryChip(
                        category: TaskCategory.finances,
                        selected: _selectedCategory == TaskCategory.finances,
                        onTap: () {
                          setDialogState(() {
                          _selectedCategory = TaskCategory.finances;
                        });
                      },
                    ),
                  ],
                ),

const SizedBox(height: 12),

Row(
  children: [
    CategoryChip(
      category: TaskCategory.family,
      selected: _selectedCategory == TaskCategory.family,
      onTap: () {
        setDialogState(() {
          _selectedCategory = TaskCategory.family;
        });
      },
    ),

    const SizedBox(width: 12),

    CategoryChip(
      category: TaskCategory.school,
      selected: _selectedCategory == TaskCategory.school,
      onTap: () {
        setDialogState(() {
          _selectedCategory = TaskCategory.school;
        });
      },
    ),
  ],
),

                    const SizedBox(height: 16),

                    
const SizedBox(height: 20),

const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Priority",
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 12),

Row(
  children: [
    PriorityChip(
      priority: TaskPriority.low,
      selected: _selectedPriority == TaskPriority.low,
      onTap: () {
        setDialogState(() {
          _selectedPriority = TaskPriority.low;
        });
      },
    ),

    const SizedBox(width: 12),

    PriorityChip(
      priority: TaskPriority.medium,
      selected: _selectedPriority == TaskPriority.medium,
      onTap: () {
        setDialogState(() {
          _selectedPriority = TaskPriority.medium;
        });
      },
    ),

    const SizedBox(width: 12),

    PriorityChip(
      priority: TaskPriority.high,
      selected: _selectedPriority == TaskPriority.high,
      onTap: () {
        setDialogState(() {
          _selectedPriority = TaskPriority.high;
        });
      },
    ),
  ],
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
           TaskHeader(
  searchController: _search,
  onSearchChanged: (_) {
    setState(() {});
  },
  totalTasks: totalTasks,
  completedTasks: completedTasks,
  openTasks: openTasks,
  completionRate: completionRate,
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
  child: TaskList(
    tasks: tasks,
    filter: _filter == "All"
        ? TaskFilter.all
        : _filter == "Open"
            ? TaskFilter.open
            : TaskFilter.completed,
    category: null,
    onAddTask: () => _showTaskDialog(),
    onToggle: (task) async {
      setState(() {
       task.completed = !task.completed;
     });

    if (task.completed) {
      final nextTask =
        RecurringTaskService.generateNext(task);

    if (nextTask != null) {
      final exists = _tasks.any(
        (t) =>
            t.title == nextTask.title &&
            t.dueDate == nextTask.dueDate,
      );

      if (!exists) {
        setState(() {
          _tasks.add(nextTask);
        });
      }
    }
  }

  await _saveTasks();
},
   onEdit: (task) async {
    await showDialog(
      context: context,
      builder: (_) => TaskDialog(
        task: task,
        onSave: (updatedTask) async {
          final index = _tasks.indexWhere(
            (t) => t.id == updatedTask.id,
          );

          if (index == -1) return;

          setState(() {
            _tasks[index] = updatedTask;
          });

          await _saveTasks();
        },
      ),
    );
  },
    onDelete: (task) {
      setState(() {
        _tasks.remove(task);
      });
      _saveTasks();
    },
  ), // <-- closes TaskList
),   // <-- closes Expanded
          ],
        ),
      ),
    );
  }
}