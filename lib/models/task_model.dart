enum Priority { low, medium, high }

class Task {
  final String id;
  final String title;
  final String description;
  final String subject;
  final DateTime dueDate;
  final Priority priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}
