import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import '../../services/budget_service.dart';
import 'transaction_dialog.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<FinanceTransaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final transactions =
        await BudgetService.loadTransactions();

    transactions.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    if (!mounted) return;

    setState(() {
      _transactions = transactions;
    });
  }

  Future<void> _saveTransactions() async {
    await BudgetService.saveTransactions(
      _transactions,
    );
  }

  Future<void> _addTransaction() async {
    await showDialog(
      context: context,
      builder: (_) => TransactionDialog(
        onSave: (transaction) async {
          setState(() {
            _transactions.add(transaction);

            _transactions.sort(
              (a, b) => b.date.compareTo(a.date),
            );
          });

          await _saveTransactions();
        },
      ),
    );
  }

  Future<void> _editTransaction(
    FinanceTransaction transaction,
  ) async {
    await showDialog(
      context: context,
      builder: (_) => TransactionDialog(
        transaction: transaction,
        onSave: (updated) async {
          final index = _transactions.indexWhere(
            (t) => t.id == updated.id,
          );

          if (index == -1) return;

          setState(() {
            _transactions[index] = updated;

            _transactions.sort(
              (a, b) => b.date.compareTo(a.date),
            );
          });

          await _saveTransactions();
        },
      ),
    );
  }

  Future<void> _deleteTransaction(
    FinanceTransaction transaction,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Transaction"),
        content: Text(
          'Delete "${transaction.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _transactions.remove(transaction);
    });

    await _saveTransactions();
  }

  String _currency(double value) {
    return "\$${value.toStringAsFixed(2)}";
  }

  String _date(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final income =
        BudgetService.totalIncome(_transactions);

    final expenses =
        BudgetService.totalExpenses(_transactions);

    final balance =
        BudgetService.balance(_transactions);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"),
      ),
            floatingActionButton: FloatingActionButton(
        onPressed: _addTransaction,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "Current Balance",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          _currency(balance),
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: balance >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.arrow_downward,
                                color: Colors.green,
                              ),

                              const SizedBox(height: 8),

                              const Text("Income"),

                              const SizedBox(height: 4),

                              Text(
                                _currency(income),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
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
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.red,
                              ),

                              const SizedBox(height: 8),

                              const Text("Expenses"),

                              const SizedBox(height: 4),

                              Text(
                                _currency(expenses),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: _transactions.isEmpty
                ? const Center(
                    child: Text(
                      "No transactions yet.\nTap + to add one.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          _transactions[index];

                      final isIncome =
                          transaction.type ==
                              TransactionType.income;

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isIncome
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            child: Icon(
                              isIncome
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: isIncome
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          title: Text(transaction.title),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(transaction.category),
                              Text(_date(transaction.date)),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.end,
                            children: [
                              Text(
                                _currency(
                                  transaction.amount,
                                ),
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  color: isIncome
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                ),
                                onPressed: () =>
                                    _deleteTransaction(
                                  transaction,
                                ),
                              ),
                            ],
                          ),
                          onTap: () =>
                              _editTransaction(
                            transaction,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}