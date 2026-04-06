import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final dynamic task;
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
    return const Card(child: ListTile(title: Text('مهمة')));
  }
}
