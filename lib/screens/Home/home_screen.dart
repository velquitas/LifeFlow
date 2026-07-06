import 'package:flutter/material.dart';

import '../../models/dashboard_summary.dart';
import '../../services/dashboard_summary_service.dart';

import '../../widgets/dashboard_header.dart';
import '../../widgets/dashboard_summary_card.dart';
import '../../widgets/focus_card.dart';
import '../../widgets/stats_section.dart';
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
  DashboardSummary? _summary;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final summary =
        await DashboardSummaryService.loadSummary();

    if (!mounted) return;

    setState(() {
      _summary = summary;
    });
  }

  String get _greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "☀️ Good Morning";
    } else if (hour < 17) {
      return "🌤 Good Afternoon";
    } else {
      return "🌙 Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = _summary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("LifeFlow"),
        centerTitle: true,
      ),
      body: summary == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [

                DashboardHeader(
                  greeting: _greeting,
                ),

                DashboardSummaryCard(
                  summary: summary,
                ),

                const SizedBox(height: 24),

                FocusCard(
                  openTasks: summary.openTasks,
                  completedTasks: summary.completedTasks,
                ),

                const SizedBox(height: 24),

                const SectionTitle(
                  title: "Today's Progress",
                ),

                StatsSection(
                  totalTasks: summary.totalTasks,
                  openTasks: summary.openTasks,
                  completedTasks: summary.completedTasks,
                  completionRate: summary.completionRate,
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
    );
  }
}