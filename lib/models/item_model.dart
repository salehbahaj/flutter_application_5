import 'package:flutter/material.dart';

class Subject {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  Subject({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}

enum TaskPriority { low, medium, high }

class Task {
  final String id;
  final String subjectId;
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  TaskPriority priority;

  Task({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.priority = TaskPriority.medium,
  });
}
