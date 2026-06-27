
import 'package:flutter/material.dart';

import '../tasks/task_screen.dart';
import '../planner/planner_screen.dart';
import '../budget/budget_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _moduleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
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
            'Choose a module',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _moduleCard(
            context,
            title: 'Tasks',
            subtitle: 'Manage your to-do list',
            icon: Icons.check_circle,
            page: const TaskScreen(),
          ),
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
