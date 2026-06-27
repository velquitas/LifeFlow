import 'package:flutter/material.dart';
import '../../widgets/progress_ring.dart';
import '../../models/task.dart';
import '../../services/storage_service.dart';
import '../../widgets/task_card.dart';
import 'package:intl/intl.dart';
import '../../widgets/dashboard_card.dart';
import '../planner/planner_screen.dart';
import '../budget/budget_screen.dart';
import '../profile/profile_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String get greeting {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return "Good Morning";
  }

  if (hour < 17) {
    return "Good Afternoon";
  }

  return "Good Evening";
}

String get formattedDate {
  return DateFormat('EEEE, MMMM d').format(DateTime.now());
}
  final TextEditingController taskController = TextEditingController();

  final List<Task> tasks = [
    Task(title: "Grocery Shopping", priorityColor: Colors.red),
    Task(title: "Gym", priorityColor: Colors.orange),
    Task(title: "Finish LifeFlow", priorityColor: Colors.green),
  ];

  int get completedTasks =>
      tasks.where((t) => t.isCompleted).length;

  double get progress =>
      tasks.isEmpty ? 0 : completedTasks / tasks.length;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final saved = await StorageService.loadTasks();

    if (!mounted) return;

    if (saved.isNotEmpty) {
      setState(() {
        tasks
          ..clear()
          ..addAll(saved);
      });
    }
  }

  Future<void> saveTasks() async {
    await StorageService.saveTasks(tasks);
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          controller: taskController,
          decoration:
              const InputDecoration(hintText: "Enter a task"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (taskController.text.trim().isEmpty) return;

              setState(() {
                tasks.add(
                  Task(
                    title: taskController.text.trim(),
                    priorityColor: Colors.blue,
                  ),
                );
              });

              saveTasks();
              taskController.clear();

              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(greeting),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
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
            const SizedBox(height: 8),
            Text(
              formattedDate,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Card(
              color: const Color(0xFFE8F1E7),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Today's Progress",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ProgressRing(
                        progress: progress,
                        size: 140,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$completedTasks of ${tasks.length} Tasks Complete",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 30),

const Text(
  "Quick Actions",
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

Row(
  children: [
    Expanded(
      child: DashboardCard(
        title: "Tasks",
        icon: Icons.check_circle,
        accentColor: Colors.blue,
        child: const Text(
          "Manage\nToday's Tasks",
          textAlign: TextAlign.center,
        ),
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: DashboardCard(
        title: "Planner",
        icon: Icons.calendar_month,
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const PlannerScreen(),
    ),
  );
},
        accentColor: Colors.green,
        child: const Text(
          "View\nSchedule",
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ],
),

const SizedBox(height: 16),

Row(
  children: [
    Expanded(
      child: DashboardCard(
        title: "Budget",
        icon: Icons.account_balance_wallet,
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const BudgetScreen(),
    ),
  );
},
        accentColor: Colors.orange,
        child: const Text(
          "Track\nExpenses",
          textAlign: TextAlign.center,
        ),
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: DashboardCard(
        title: "Habits",
        icon: Icons.favorite,
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ProfileScreen(),
    ),
  );
},
        accentColor: Colors.red,
        child: const Text(
          "Daily\nHabits",
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ],
),

const SizedBox(height: 30),
            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...tasks.map((task) {
              return Dismissible(
                key: ValueKey(task.title),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (_) {
                  setState(() {
                    tasks.remove(task);
                  });
                  saveTasks();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${task.title} deleted"),
                    ),
                  );
                },
                child: TaskCard(
                  title: task.title,
                  priorityColor: task.priorityColor,
                  isCompleted: task.isCompleted,
                  onTap: () {
                    setState(() {
                      task.isCompleted = !task.isCompleted;
                    });
                    saveTasks();
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}