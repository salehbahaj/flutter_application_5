import 'package:flutter/material.dart';
import '../models/item_model.dart';

// تغيير من final إلى var لتصبح قابلة للتعديل
List<Subject> subjects = [
  Subject(
    id: 's1',
    name: 'الرياضيات',
    color: Colors.blue,
    icon: Icons.calculate,
  ),
  Subject(
    id: 's2',
    name: 'الفيزياء',
    color: Colors.purple,
    icon: Icons.science,
  ),
  Subject(
    id: 's3',
    name: 'البرمجة',
    color: Colors.green,
    icon: Icons.code,
  ),
  Subject(
    id: 's4',
    name: 'الكيمياء',
    color: Colors.orange,
    icon: Icons.biotech,
  ),
  Subject(
    id: 's5',
    name: 'اللغة الإنجليزية',
    color: Colors.red,
    icon: Icons.language,
  ),
];

List<Task> tasks = [
  // Math tasks
  Task(
    id: 't1',
    subjectId: 's1',
    title: 'حل تمارين الجبر',
    description: 'حل التمارين من صفحة 45 إلى 50',
    dueDate: DateTime.now().add(const Duration(days: 2)),
    isCompleted: false,
    priority: TaskPriority.high,
  ),
  Task(
    id: 't2',
    subjectId: 's1',
    title: 'مراجعة الهندسة',
    description: 'مراجعة الفصل الثالث كاملاً',
    dueDate: DateTime.now().add(const Duration(days: 5)),
    isCompleted: true,
    priority: TaskPriority.medium,
  ),
  Task(
    id: 't3',
    subjectId: 's1',
    title: 'الاختبار الشهري',
    description: 'الاستعداد للاختبار الشهري',
    dueDate: DateTime.now().add(const Duration(days: 7)),
    isCompleted: false,
    priority: TaskPriority.high,
  ),

  // Physics tasks
  Task(
    id: 't4',
    subjectId: 's2',
    title: 'تقرير التجربة',
    description: 'كتابة تقرير عن تجربة الحركة',
    dueDate: DateTime.now().add(const Duration(days: 3)),
    isCompleted: false,
    priority: TaskPriority.high,
  ),
  Task(
    id: 't5',
    subjectId: 's2',
    title: 'حل أسئلة الكتاب',
    description: 'حل أسئلة الفصل الرابع',
    dueDate: DateTime.now().add(const Duration(days: 4)),
    isCompleted: false,
    priority: TaskPriority.low,
  ),

  // Programming tasks
  Task(
    id: 't6',
    subjectId: 's3',
    title: 'مشروع Flutter',
    description: 'إكمال تطبيق إدارة المهام',
    dueDate: DateTime.now().add(const Duration(days: 10)),
    isCompleted: false,
    priority: TaskPriority.high,
  ),
  Task(
    id: 't7',
    subjectId: 's3',
    title: 'دراسة Dart',
    description: 'مراجعة أساسيات لغة Dart',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    isCompleted: true,
    priority: TaskPriority.medium,
  ),
  Task(
    id: 't8',
    subjectId: 's3',
    title: 'واجب الخوارزميات',
    description: 'حل مسائل الخوارزميات',
    dueDate: DateTime.now().add(const Duration(days: 6)),
    isCompleted: false,
    priority: TaskPriority.medium,
  ),

  // Chemistry tasks
  Task(
    id: 't9',
    subjectId: 's4',
    title: 'حفظ الجدول الدوري',
    description: 'حفظ العناصر من 1 إلى 20',
    dueDate: DateTime.now().add(const Duration(days: 3)),
    isCompleted: true,
    priority: TaskPriority.low,
  ),
  Task(
    id: 't10',
    subjectId: 's4',
    title: 'تجربة معملية',
    description: 'إجراء تجربة التفاعلات الكيميائية',
    dueDate: DateTime.now().add(const Duration(days: 8)),
    isCompleted: false,
    priority: TaskPriority.medium,
  ),

  // English tasks
  Task(
    id: 't11',
    subjectId: 's5',
    title: 'كتابة مقال',
    description: 'كتابة مقال عن التكنولوجيا',
    dueDate: DateTime.now().add(const Duration(days: 4)),
    isCompleted: false,
    priority: TaskPriority.high,
  ),
  Task(
    id: 't12',
    subjectId: 's5',
    title: 'حفظ المفردات',
    description: 'حفظ 50 كلمة جديدة',
    dueDate: DateTime.now().add(const Duration(days: 2)),
    isCompleted: true,
    priority: TaskPriority.low,
  ),
];
