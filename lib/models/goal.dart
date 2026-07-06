class Goal {
  final String id;
  final String title;
  final double target;
  final double progress;
  final DateTime? deadline;

  Goal({
    required this.id,
    required this.title,
    required this.target,
    this.progress = 0,
    this.deadline,
  });

  double get percentComplete {
    if (target == 0) return 0;
    return (progress / target).clamp(0.0, 1.0);
  }

  Goal copyWith({
    String? id,
    String? title,
    double? target,
    double? progress,
    DateTime? deadline,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      target: target ?? this.target,
      progress: progress ?? this.progress,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "target": target,
      "progress": progress,
      "deadline": deadline?.toIso8601String(),
    };
  }

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json["id"],
      title: json["title"],
      target: (json["target"] as num).toDouble(),
      progress: (json["progress"] ?? 0).toDouble(),
      deadline: json["deadline"] == null
          ? null
          : DateTime.parse(json["deadline"]),
    );
  }
}