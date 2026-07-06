import 'package:flutter/material.dart';

class BudgetSnapshotCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expenses;

  const BudgetSnapshotCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expenses,
  });

  String _currency(double value) {
    return "\$${value.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.account_balance_wallet),
                SizedBox(width: 8),
                Text(
                  "Budget Snapshot",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  const Text(
                    "Current Balance",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    _currency(balance),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: balance >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                      ),

                      const SizedBox(height: 6),

                      const Text("Income"),

                      Text(
                        _currency(income),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.arrow_upward,
                        color: Colors.red,
                      ),

                      const SizedBox(height: 6),

                      const Text("Expenses"),

                      Text(
                        _currency(expenses),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}