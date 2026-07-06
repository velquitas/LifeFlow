import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';

class BudgetService {
  static const String _storageKey = "lifeflow_transactions";

  static Future<List<FinanceTransaction>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      return [];
    }

    final List decoded = jsonDecode(jsonString);

    return decoded
        .map((e) => FinanceTransaction.fromJson(e))
        .toList();
  }

  static Future<void> saveTransactions(
    List<FinanceTransaction> transactions,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(
      transactions.map((e) => e.toJson()).toList(),
    );

    await prefs.setString(_storageKey, jsonString);
  }

  static Future<void> clearTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  static double totalIncome(
    List<FinanceTransaction> transactions,
  ) {
    return transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  static double totalExpenses(
    List<FinanceTransaction> transactions,
  ) {
    return transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  static double balance(
    List<FinanceTransaction> transactions,
  ) {
    return totalIncome(transactions) -
        totalExpenses(transactions);
  }
}