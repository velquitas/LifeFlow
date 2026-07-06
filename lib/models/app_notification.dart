class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final bool read;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.read = false,
  });

  AppNotification copyWith({
    bool? read,
  }) {
    return AppNotification(
      id: id,
      title: title,
      message: message,
      date: date,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "message": message,
      "date": date.toIso8601String(),
      "read": read,
    };
  }

  factory AppNotification.fromJson(
    Map<String, dynamic> json,
  ) {
    return AppNotification(
      id: json["id"],
      title: json["title"],
      message: json["message"],
      date: DateTime.parse(json["date"]),
      read: json["read"] ?? false,
    );
  }
}