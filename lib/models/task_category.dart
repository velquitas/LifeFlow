import 'package:flutter/material.dart';

enum TaskCategory {
  personal,
  work,
  health,
  finances,
  family,
  shopping,
  home,
  school,
}

extension TaskCategoryExtension on TaskCategory {
  String get displayName {
    switch (this) {
      case TaskCategory.personal:
        return "Personal";
      case TaskCategory.work:
        return "Work";
      case TaskCategory.health:
        return "Health";
      case TaskCategory.finances:
        return "Finances";
      case TaskCategory.family:
        return "Family";
      case TaskCategory.shopping:
        return "Shopping";
      case TaskCategory.home:
        return "Home";
      case TaskCategory.school:
        return "School";
    }
  }

  IconData get icon {
    switch (this) {
      case TaskCategory.personal:
        return Icons.person;

      case TaskCategory.work:
        return Icons.work;

      case TaskCategory.health:
        return Icons.favorite;

      case TaskCategory.finances:
        return Icons.attach_money;

      case TaskCategory.family:
        return Icons.family_restroom;

      case TaskCategory.shopping:
        return Icons.shopping_cart;

      case TaskCategory.home:
        return Icons.home;

      case TaskCategory.school:
        return Icons.school;
    }
  }

  Color get color {
    switch (this) {
      case TaskCategory.personal:
        return Colors.blue;

      case TaskCategory.work:
        return Colors.indigo;

      case TaskCategory.health:
        return Colors.red;

      case TaskCategory.finances:
        return Colors.green;

      case TaskCategory.family:
        return Colors.purple;

      case TaskCategory.shopping:
        return Colors.orange;

      case TaskCategory.home:
        return Colors.brown;

      case TaskCategory.school:
        return Colors.teal;
    }
  }
}