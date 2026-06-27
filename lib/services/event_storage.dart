
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/event.dart';

class EventStorage {
  static const String _storageKey = 'planner_events';

  static Future<void> saveEvents(List<PlannerEvent> events) async {
    final prefs = await SharedPreferences.getInstance();

    final data = events
        .map((event) => jsonEncode(event.toJson()))
        .toList();

    await prefs.setStringList(_storageKey, data);
  }

  static Future<List<PlannerEvent>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(_storageKey);

    if (data == null) {
      return [];
    }

    return data
        .map(
          (item) => PlannerEvent.fromJson(
            jsonDecode(item) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  static Future<void> clearEvents() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
