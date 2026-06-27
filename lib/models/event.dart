class PlannerEvent {
  final String title;
  final DateTime date;
  final String category;
  final String? notes;

  PlannerEvent({
    required this.title,
    required this.date,
    this.category = "General",
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'category': category,
      'notes': notes,
    };
  }

  factory PlannerEvent.fromJson(Map<String, dynamic> json) {
    return PlannerEvent(
      title: json['title'],
      date: DateTime.parse(json['date']),
      category: json['category'] ?? "General",
      notes: json['notes'],
    );
  }
}