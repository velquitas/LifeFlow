enum TransactionType {
  income,
  expense,
}

class FinanceTransaction {
  String id;
  String title;
  double amount;
  DateTime date;
  TransactionType type;
  String category;

  FinanceTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "amount": amount,
      "date": date.toIso8601String(),
      "type": type.index,
      "category": category,
    };
  }

  factory FinanceTransaction.fromJson(
      Map<String, dynamic> json) {
    return FinanceTransaction(
      id: json["id"],
      title: json["title"],
      amount: (json["amount"] as num).toDouble(),
      date: DateTime.parse(json["date"]),
      type: TransactionType.values[json["type"]],
      category: json["category"],
    );
  }
}