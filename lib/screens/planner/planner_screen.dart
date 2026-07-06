import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/planner_event.dart';
import '../../services/planner_service.dart';
import 'event_dialog.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  List<PlannerEvent> _events = [];

  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await PlannerService.loadEvents();

    events.sort((a, b) => a.start.compareTo(b.start));

    if (!mounted) return;

    setState(() {
      _events = events;
    });
  }

  Future<void> _saveEvents() async {
    await PlannerService.saveEvents(_events);
  }

  List<PlannerEvent> _eventsForDay(DateTime day) {
    return _events.where((event) {
      return event.start.year == day.year &&
          event.start.month == day.month &&
          event.start.day == day.day;
    }).toList();
  }

  Future<void> _addEvent() async {
    await showDialog(
      context: context,
      builder: (_) => EventDialog(
        onSave: (event) async {
          setState(() {
            _events.add(event);
            _events.sort((a, b) => a.start.compareTo(b.start));
          });

          await _saveEvents();
        },
      ),
    );
  }

  Future<void> _editEvent(PlannerEvent event) async {
    await showDialog(
      context: context,
      builder: (_) => EventDialog(
        event: event,
        onSave: (updated) async {
          final index =
              _events.indexWhere((e) => e.id == updated.id);

          if (index == -1) return;

          setState(() {
            _events[index] = updated;
            _events.sort((a, b) => a.start.compareTo(b.start));
          });

          await _saveEvents();
        },
      ),
    );
  }

  Future<void> _deleteEvent(PlannerEvent event) async {
    final delete = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Event"),
        content: Text(
          'Delete "${event.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (delete != true) return;

    setState(() {
      _events.remove(event);
    });

    await _saveEvents();
  }

  String _time(PlannerEvent event) {
    if (event.allDay) {
      return "All Day";
    }

    final start =
        TimeOfDay.fromDateTime(event.start).format(context);

    final end =
        TimeOfDay.fromDateTime(event.end).format(context);

    return "$start • $end";
  }

  @override
  Widget build(BuildContext context) {
    final todaysEvents = _eventsForDay(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Planner"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar<PlannerEvent>(
            firstDay: DateTime(2020),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) =>
                isSameDay(day, _selectedDay),
            eventLoader: _eventsForDay,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),

          const Divider(),

          Expanded(
            child: todaysEvents.isEmpty
                ? const Center(
                    child: Text(
                      "No events for this day",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: todaysEvents.length,
                    itemBuilder: (context, index) {
                      final event = todaysEvents[index];

                      return Card(
                        margin:
                            const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: event.allDay
                                ? const Icon(Icons.today)
                                : const Icon(Icons.schedule),
                          ),
                          title: Text(event.title),
                          subtitle: Text(_time(event)),
                          onTap: () => _editEvent(event),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                            onPressed: () =>
                                _deleteEvent(event),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}