import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../utils/helpers.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onChanged;

  const TaskItem({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = DateHelper.isOverdue(task.dueDate, task.isCompleted);

    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          color: isOverdue && !task.isCompleted ? Colors.red : null,
        ),
      ),
      subtitle: Text(
        DateHelper.getDaysRemainingText(task.dueDate),
        style: TextStyle(
          color: isOverdue && !task.isCompleted ? Colors.red : Colors.grey,
        ),
      ),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (val) {
          task.isCompleted = val!;
          onChanged();
        },
      ),
    );
  }
}
