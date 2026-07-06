enum TaskRepeat {
  never,
  daily,
  weekly,
  monthly,
  yearly,
}

extension TaskRepeatExtension on TaskRepeat {
  String get displayName {
    switch (this) {
      case TaskRepeat.never:
        return "Never";
      case TaskRepeat.daily:
        return "Daily";
      case TaskRepeat.weekly:
        return "Weekly";
      case TaskRepeat.monthly:
        return "Monthly";
      case TaskRepeat.yearly:
        return "Yearly";
    }
  }
}