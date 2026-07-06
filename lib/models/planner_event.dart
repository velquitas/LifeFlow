class PlannerEvent {
  String id;
  String title;
  DateTime start;
  DateTime end;
  bool allDay;

  PlannerEvent({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    this.allDay = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'allDay': allDay,
      };

  factory PlannerEvent.fromJson(Map<String, dynamic> json) {
    return PlannerEvent(
      id: json['id'],
      title: json['title'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      allDay: json['allDay'] ?? false,
    );
  }
}