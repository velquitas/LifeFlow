import 'package:flutter/material.dart';

import '../tasks/task_screen.dart';
import '../planner/planner_screen.dart';
import '../budget/budget_screen.dart';
import '../profile/profile_screen.dart';

import '../../widgets/dashboard_card.dart';
import '../../services/dashboard_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _openTasks = 0;
  int _completedTasks = 0;
  int _totalTasks = 0;
  double _completionRate = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final open = await DashboardService.getOpenTaskCount();
    final completed = await DashboardService.getCompletedTaskCount();
    final total = await DashboardService.getTotalTaskCount();
    final rate = await DashboardService.getTaskCompletionRate();

    if (!mounted) return;

    setState(() {
      _openTasks = open;
      _completedTasks = completed;
      _totalTasks = total;
      _completionRate = rate;
    });
  }

  Widget _moduleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          ).then((_) => _loadDashboard());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeFlow'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Your Life at a Glance',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          DashboardCard(
            title: "Today's Tasks",
            icon: Icons.check_circle,
            accentColor: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TaskScreen(),
                ),
              ).then((_) => _loadDashboard());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$_totalTasks Total Tasks",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "$_openTasks Open",
                  style: const TextStyle(fontSize: 16),
                ),

                Text(
                  "$_completedTasks Completed",
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 12),

                LinearProgressIndicator(
                  value: _completionRate,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                ),

                const SizedBox(height: 8),

                Text(
                  "${(_completionRate * 100).toStringAsFixed(0)}% Complete",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _moduleCard(
            context,
            title: 'Planner',
            subtitle: 'Calendar & events',
            icon: Icons.calendar_month,
            page: const PlannerScreen(),
          ),

          _moduleCard(
            context,
            title: 'Budget',
            subtitle: 'Track income & expenses',
            icon: Icons.account_balance_wallet,
            page: const BudgetScreen(),
          ),

          _moduleCard(
            context,
            title: 'Profile',
            subtitle: 'Settings & preferences',
            icon: Icons.person,
            page: const ProfileScreen(),
          ),
        ],
      ),
    );
  }
}