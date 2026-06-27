import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../planner/planner_screen.dart';
import '../budget/budget_screen.dart';
import '../profile/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    PlannerScreen(),
    BudgetScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: "Planner",
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            label: "Budget",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}