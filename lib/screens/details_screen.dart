import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class DetailsScreen extends StatelessWidget {
  final Task task;
  const DetailsScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('تفاصيل المهمة'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (task.isCompleted)
                      const Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
                const Divider(height: 32),
                _buildDetailRow(Icons.subject, 'المادة', task.subject),
                _buildDetailRow(
                  Icons.calendar_today,
                  'تاريخ الاستحقاق',
                  DateFormat('yyyy-MM-dd').format(task.dueDate),
                ),
                _buildDetailRow(
                  Icons.flag,
                  'الأولوية',
                  task.priority == Priority.low
                      ? 'منخفضة'
                      : task.priority == Priority.medium
                      ? 'متوسطة'
                      : 'عالية',
                ),
                _buildDetailRow(Icons.description, 'الوصف', task.description),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    task.isCompleted ? '✓ مكتملة' : '○ غير مكتملة',
                    style: TextStyle(
                      color: task.isCompleted ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
