import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../models/subject_model.dart';

// قائمة المواد الأولية
List<Subject> subjects = [
  Subject(
    id: '1',
    name: 'الرياضيات',
    icon: Icons.calculate,
    color: Color(0xFF4A6FA5),
  ),
  Subject(
    id: '2',
    name: 'العلوم',
    icon: Icons.science,
    color: Color(0xFF2E8B57),
  ),
  Subject(
    id: '3',
    name: 'اللغة العربية',
    icon: Icons.menu_book,
    color: Color(0xFFD2691E),
  ),
  Subject(
    id: '4',
    name: 'اللغة الإنجليزية',
    icon: Icons.translate,
    color: Color(0xFF8B4513),
  ),
  Subject(
    id: '5',
    name: 'التاريخ',
    icon: Icons.history,
    color: Color(0xFF6A0DAD),
  ),
];

// قائمة المهام الأولية
List<Task> dummyTasks = [
  Task(
    id: '1',
    title: 'حل تمرين الرياضيات',
    description: 'تمارين الصفحة ٤٢',
    subject: 'الرياضيات',
    dueDate: DateTime(2026, 4, 5),
    priority: Priority.high,
  ),
  Task(
    id: '2',
    title: 'كتابة بحث العلوم',
    description: 'بحث عن النظام الشمسي',
    subject: 'العلوم',
    dueDate: DateTime(2026, 4, 7),
    priority: Priority.medium,
  ),
  Task(
    id: '3',
    title: 'مراجعة اللغة العربية',
    description: 'قواعد النحو',
    subject: 'اللغة العربية',
    dueDate: DateTime(2026, 4, 4),
    priority: Priority.low,
  ),
  Task(
    id: '4',
    title: 'حل واجب الإنجليزي',
    description: 'تمارين الوحدة الثالثة',
    subject: 'اللغة الإنجليزية',
    dueDate: DateTime(2026, 4, 6),
    priority: Priority.medium,
  ),
  Task(
    id: '5',
    title: 'مشروع التاريخ',
    description: 'الحضارة الإسلامية',
    subject: 'التاريخ',
    dueDate: DateTime(2026, 4, 10),
    priority: Priority.high,
  ),
];
