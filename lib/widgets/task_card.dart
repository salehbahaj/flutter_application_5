import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Checkbox(
                value: task.isCompleted,
                onChanged: (_) => onToggle(),
                activeColor: primaryColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${task.subject} • ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    if (task.description.isNotEmpty)
                      Text(
                        task.description,
                        style: const TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              Icon(
                task.priority == Priority.high
                    ? Icons.flag
                    : task.priority == Priority.medium
                    ? Icons.flag
                    : Icons.flag_outlined,
                color: task.priority == Priority.high
                    ? Colors.red
                    : task.priority == Priority.medium
                    ? Colors.orange
                    : Colors.green,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
