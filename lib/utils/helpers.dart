import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  static String formatDateArabic(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static bool isOverdue(DateTime dueDate, bool isCompleted) {
    return dueDate.isBefore(DateTime.now()) && !isCompleted;
  }

  static int getDaysRemaining(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now);
    return difference.inDays;
  }

  static String getDaysRemainingText(DateTime dueDate) {
    final days = getDaysRemaining(dueDate);
    if (days < 0) {
      return 'متأخر ${-days} يوم';
    } else if (days == 0) {
      return 'اليوم';
    } else if (days == 1) {
      return 'غداً';
    } else {
      return 'باقي $days يوم';
    }
  }
}

class TaskHelper {
  static int getCompletedTasksCount(List tasks) {
    return tasks.where((t) => t.isCompleted).length;
  }

  static int getIncompleteTasksCount(List tasks) {
    return tasks.where((t) => !t.isCompleted).length;
  }

  static double getCompletionPercentage(List tasks) {
    if (tasks.isEmpty) return 0.0;
    final completed = getCompletedTasksCount(tasks);
    return (completed / tasks.length) * 100;
  }
}
