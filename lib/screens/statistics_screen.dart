import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../utils/constants.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalTasks = dummyTasks.length;
    final completedTasks = dummyTasks.where((t) => t.isCompleted).length;
    final pendingTasks = totalTasks - completedTasks;
    final completionRate = totalTasks == 0
        ? 0.0
        : (completedTasks / totalTasks) * 100;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('الإحصائيات'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'نسبة الإنجاز',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: completionRate / 100,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey.shade300,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          '${completionRate.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildStatRow('إجمالي المهام', totalTasks.toString()),
                    const Divider(color: Colors.grey),
                    _buildStatRow('المهام المكتملة', completedTasks.toString()),
                    const Divider(color: Colors.grey),
                    _buildStatRow('المهام المتبقية', pendingTasks.toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'توزيع المهام حسب المواد',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...subjects.map((subject) {
                      final count = dummyTasks
                          .where((t) => t.subject == subject.name)
                          .length;
                      return _buildSubjectStatRow(subject.name, count);
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectStatRow(String subject, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject, style: const TextStyle(fontSize: 14)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$count مهام', style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
