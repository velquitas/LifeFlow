import 'package:flutter/material.dart';

import '../../models/planner_event.dart';

class EventDialog extends StatefulWidget {
  final PlannerEvent? event;
  final void Function(PlannerEvent event) onSave;

  const EventDialog({
    super.key,
    this.event,
    required this.onSave,
  });

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  late TextEditingController _titleController;

  late DateTime _start;
  late DateTime _end;

  bool _allDay = false;

  @override
  void initState() {
    super.initState();

    final event = widget.event;

    _titleController =
        TextEditingController(text: event?.title ?? "");

    _start = event?.start ?? DateTime.now();

    _end = event?.end ??
        DateTime.now().add(
          const Duration(hours: 1),
        );

    _allDay = event?.allDay ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _start : _end,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      if (isStart) {
        _start = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _start.hour,
          _start.minute,
        );
      } else {
        _end = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _end.hour,
          _end.minute,
        );
      }
    });
  }

  Future<void> _pickTime(bool isStart) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        isStart ? _start : _end,
      ),
    );

    if (time == null) return;

    setState(() {
      if (isStart) {
        _start = DateTime(
          _start.year,
          _start.month,
          _start.day,
          time.hour,
          time.minute,
        );
      } else {
        _end = DateTime(
          _end.year,
          _end.month,
          _end.day,
          time.hour,
          time.minute,
        );
      }
    });
  }

  void _save() {
    if (_titleController.text.trim().isEmpty) return;

    widget.onSave(
      PlannerEvent(
        id: widget.event?.id ??
            DateTime.now()
                .millisecondsSinceEpoch
                .toString(),
        title: _titleController.text.trim(),
        start: _start,
        end: _end,
        allDay: _allDay,
      ),
    );

    Navigator.pop(context);
  }

  String _format(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  String _time(DateTime date) {
    return TimeOfDay.fromDateTime(date).format(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.event == null
            ? "New Event"
            : "Edit Event",
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Event Title",
                ),
              ),

              const SizedBox(height: 20),

              SwitchListTile(
                title: const Text("All Day Event"),
                value: _allDay,
                onChanged: (value) {
                  setState(() {
                    _allDay = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text("Start Date"),
                subtitle: Text(_format(_start)),
                onTap: () => _pickDate(true),
              ),

              if (!_allDay)
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: const Text("Start Time"),
                  subtitle: Text(_time(_start)),
                  onTap: () => _pickTime(true),
                ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text("End Date"),
                subtitle: Text(_format(_end)),
                onTap: () => _pickDate(false),
              ),

              if (!_allDay)
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: const Text("End Time"),
                  subtitle: Text(_time(_end)),
                  onTap: () => _pickTime(false),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(
            widget.event == null
                ? "Create"
                : "Save",
          ),
        ),
      ],
    );
  }
}