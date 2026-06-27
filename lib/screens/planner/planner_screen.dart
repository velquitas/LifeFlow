
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/event.dart';
import '../../services/event_storage.dart';
import '../../widgets/add_event_dialog.dart';
import '../../widgets/event_tile.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<PlannerEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await EventStorage.loadEvents();
    if (!mounted) return;
    setState(() => _events = events);
  }

  Future<void> _saveEvents() async {
    await EventStorage.saveEvents(_events);
  }

  List<PlannerEvent> get _selectedEvents => _events.where((e) =>
      e.date.year == _selectedDay.year &&
      e.date.month == _selectedDay.month &&
      e.date.day == _selectedDay.day).toList();

  Future<void> _addEvent() async {
    final PlannerEvent? event = await showDialog<PlannerEvent>(
      context: context,
      builder: (_) => AddEventDialog(selectedDate: _selectedDay),
    );

    if (event == null) return;

    setState(() => _events.add(event));
    await _saveEvents();
  }

  Future<void> _deleteEvent(PlannerEvent event) async {
    setState(() => _events.remove(event));
    await _saveEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planner')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2050),
            focusedDay: _focusedDay,
            selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Events',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          if (_selectedEvents.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.event_busy),
                title: Text('No events for this day'),
              ),
            ),
          ..._selectedEvents.map(
            (e) => EventTile(
              event: e,
              onDelete: () => _deleteEvent(e),
            ),
          ),
        ],
      ),
    );
  }
}
