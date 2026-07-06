import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/planner_event.dart';

class PlannerService {
  static const String _key = 'planner_events';

  static Future<List<PlannerEvent>> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_key);

    if (jsonString == null) {
      return [];
    }

    final List decoded = jsonDecode(jsonString);

    return decoded
        .map((e) => PlannerEvent.fromJson(e))
        .toList();
  }

  static Future<void> saveEvents(
      List<PlannerEvent> events,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(
      events.map((e) => e.toJson()).toList(),
    );

    await prefs.setString(_key, jsonString);
  }

  static Future<void> clearEvents() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}