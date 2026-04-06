import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  final String subject;
  const TasksScreen({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject)),
      body: const Center(child: Text('شاشة المهام - قيد التطوير')),
    );
  }
}
