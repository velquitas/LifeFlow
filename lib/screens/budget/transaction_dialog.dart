import 'package:flutter/material.dart';

import '../../models/transaction.dart';

class TransactionDialog extends StatefulWidget {
  final FinanceTransaction? transaction;
  final void Function(FinanceTransaction transaction) onSave;

  const TransactionDialog({
    super.key,
    this.transaction,
    required this.onSave,
  });

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  TransactionType _type = TransactionType.expense;

  String _category = "General";

  DateTime _date = DateTime.now();

  final List<String> _categories = const [
    "General",
    "Food",
    "Housing",
    "Transportation",
    "Utilities",
    "Healthcare",
    "Entertainment",
    "Shopping",
    "Salary",
    "Savings",
    "Other",
  ];

  @override
  void initState() {
    super.initState();

    final transaction = widget.transaction;

    _titleController = TextEditingController(
      text: transaction?.title ?? "",
    );

    _amountController = TextEditingController(
      text: transaction == null
          ? ""
          : transaction.amount.toString(),
    );

    if (transaction != null) {
      _type = transaction.type;
      _category = transaction.category;
      _date = transaction.date;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      _date = picked;
    });
  }

  void _save() {
    final title = _titleController.text.trim();

    final amount =
        double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) return;

    widget.onSave(
      FinanceTransaction(
        id: widget.transaction?.id ??
            DateTime.now()
                .millisecondsSinceEpoch
                .toString(),
        title: title,
        amount: amount,
        date: _date,
        type: _type,
        category: _category,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.transaction == null
            ? "New Transaction"
            : "Edit Transaction",
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: "Amount",
                  prefixText: "\$",
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<TransactionType>(
                value: _type,
                decoration: const InputDecoration(
                  labelText: "Type",
                ),
                items: const [
                  DropdownMenuItem(
                    value: TransactionType.income,
                    child: Text("Income"),
                  ),
                  DropdownMenuItem(
                    value: TransactionType.expense,
                    child: Text("Expense"),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _type = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  labelText: "Category",
                ),
                items: _categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _category = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              FilledButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  "${_date.month}/${_date.day}/${_date.year}",
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(
            widget.transaction == null
                ? "Create"
                : "Save",
          ),
        ),
      ],
    );
  }
}