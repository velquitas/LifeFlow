import 'package:flutter/material.dart';

import '../../models/task.dart';
import '../../models/task_category.dart';
import '../../models/task_repeat.dart';

import '../../widgets/category_chip.dart';
import '../../widgets/priority_chip.dart';

class TaskDialog extends StatefulWidget {
  final Task? task;
  final void Function(Task task) onSave;

  const TaskDialog({
    super.key,
    this.task,
    required this.onSave,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late TextEditingController _titleController;

  late TaskCategory _category;
  late TaskPriority _priority;
  late TaskRepeat _repeat;

  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();

    final task = widget.task;

    _titleController = TextEditingController(
      text: task?.title ?? "",
    );

    _category = task?.category ?? TaskCategory.personal;
    _priority = task?.priority ?? TaskPriority.medium;
    _repeat = task?.repeat ?? TaskRepeat.never;
    _dueDate = task?.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      _dueDate = picked;
    });
  }

  void _save() {
    final title = _titleController.text.trim();

    if (title.isEmpty) return;

    widget.onSave(
      Task(
        id: widget.task?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        category: _category,
        priority: _priority,
        repeat: _repeat,
        dueDate: _dueDate,
        completed: widget.task?.completed ?? false,
      ),
    );

    Navigator.pop(context);
  }

  Widget _categoryRow(
    TaskCategory left,
    TaskCategory right,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: CategoryChip(
              category: left,
              selected: _category == left,
              onTap: () {
                setState(() {
                  _category = left;
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CategoryChip(
              category: right,
              selected: _category == right,
              onTap: () {
                setState(() {
                  _category = right;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.task == null ? "New Task" : "Edit Task",
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Task Title",
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Category",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _categoryRow(
                TaskCategory.personal,
                TaskCategory.work,
              ),

              _categoryRow(
                TaskCategory.home,
                TaskCategory.health,
              ),

              _categoryRow(
                TaskCategory.shopping,
                TaskCategory.finances,
              ),

              _categoryRow(
                TaskCategory.family,
                TaskCategory.school,
              ),

              const SizedBox(height: 20),

              const Text(
                "Priority",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: PriorityChip(
                      priority: TaskPriority.low,
                      selected: _priority == TaskPriority.low,
                      onTap: () {
                        setState(() {
                          _priority = TaskPriority.low;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: PriorityChip(
                      priority: TaskPriority.medium,
                      selected: _priority == TaskPriority.medium,
                      onTap: () {
                        setState(() {
                          _priority = TaskPriority.medium;
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: PriorityChip(
                      priority: TaskPriority.high,
                      selected: _priority == TaskPriority.high,
                      onTap: () {
                        setState(() {
                          _priority = TaskPriority.high;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              DropdownButtonFormField<TaskRepeat>(
                value: _repeat,
                decoration: const InputDecoration(
                  labelText: "Repeat",
                  border: OutlineInputBorder(),
                ),
                items: TaskRepeat.values.map((repeat) {
                  return DropdownMenuItem(
                    value: repeat,
                    child: Text(repeat.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _repeat = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  _dueDate == null
                      ? "Select Due Date"
                      : "${_dueDate!.month}/${_dueDate!.day}/${_dueDate!.year}",
                ),
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
            widget.task == null ? "Create" : "Save",
          ),
        ),
      ],
    );
  }
}