import 'package:flutter/material.dart';

import '../../models/dashboard_data.dart';
import '../../services/dashboard_service.dart';

import '../../widgets/dashboard_header.dart';
import '../../widgets/dashboard_summary_card.dart';
import '../../widgets/focus_card.dart';
import '../../widgets/stats_section.dart';
import '../../widgets/todays_tasks_card.dart';
import '../../widgets/todays_events_card.dart';
import '../../widgets/budget_snapshot_card.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/inspiration_card.dart';
import '../../widgets/section_title.dart';

import '../tasks/task_screen.dart';
import '../planner/planner_screen.dart';
import '../budget/budget_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DashboardData? _dashboard;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    try {
      final dashboard =
          await DashboardService.loadDashboard();

      if (!mounted) return;

      setState(() {
        _dashboard = dashboard;
      });
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to load dashboard.",
          ),
        ),
      );
    }
  }

  String get _greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "☀️ Good Morning";
    }

    if (hour < 17) {
      return "🌤 Good Afternoon";
    }

    return "🌙 Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    if (_dashboard == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final dashboard = _dashboard!;
        return Scaffold(
      appBar: AppBar(
        title: const Text("LifeFlow"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboard,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            DashboardHeader(
              greeting: _greeting,
            ),

            DashboardSummaryCard(
              totalTasks: dashboard.totalTasks,
              completedTasks: dashboard.completedTasks,
              openTasks: dashboard.openTasks,
            ),

            const SizedBox(height: 24),

            FocusCard(
              openTasks: dashboard.openTasks,
              completedTasks: dashboard.completedTasks,
            ),

            const SizedBox(height: 24),

            const SectionTitle(
              title: "Today's Progress",
            ),

            StatsSection(
              totalTasks: dashboard.totalTasks,
              openTasks: dashboard.openTasks,
              completedTasks: dashboard.completedTasks,
              completionRate: dashboard.completionRate,
            ),

            const SizedBox(height: 30),

            TodaysTasksCard(
              tasks: dashboard.todaysTasks,
              onToggle: (task) async {
                task.completed = !task.completed;
                await _loadDashboard();
              },
            ),

            const SizedBox(height: 24),

            TodaysEventsCard(
              events: dashboard.todaysEvents,
            ),

            const SizedBox(height: 24),

            BudgetSnapshotCard(
              balance: dashboard.balance,
              income: dashboard.income,
              expenses: dashboard.expenses,
            ),

            const SizedBox(height: 30),

            const SectionTitle(
              title: "Quick Actions",
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    title: "Tasks",
                    icon: Icons.check_circle,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TaskScreen(),
                        ),
                      ).then((_) => _loadDashboard());
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: QuickActionCard(
                    title: "Planner",
                    icon: Icons.calendar_month,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PlannerScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
                        Row(
              children: [
                Expanded(
                  child: QuickActionCard(
                    title: "Budget",
                    icon: Icons.account_balance_wallet,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BudgetScreen(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: QuickActionCard(
                    title: "Profile",
                    icon: Icons.person,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const SectionTitle(
              title: "Coming Soon",
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                Chip(label: Text("Goals")),
                Chip(label: Text("Habits")),
                Chip(label: Text("Meals")),
                Chip(label: Text("Home")),
                Chip(label: Text("Family")),
                Chip(label: Text("Travel")),
                Chip(label: Text("Health")),
                Chip(label: Text("AI Assistant")),
              ],
            ),

            const SizedBox(height: 30),

            const InspirationCard(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}