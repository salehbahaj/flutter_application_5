import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalTasks = tasks.length;
    final completedTasks = tasks.where((t) => t.isCompleted).length;
    final incompleteTasks = totalTasks - completedTasks;
    final completionPercentage = totalTasks > 0
        ? (completedTasks / totalTasks * 100).toStringAsFixed(1)
        : '0.0';

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإحصائيات'),
      ),
      body: SingleChildScrollView(
        // التمرير الآن يشمل الصفحة كاملة
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'نظرة عامة على المهام',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildStatCard(
                'إجمالي المهام',
                totalTasks.toString(),
                Icons.assignment,
                Colors.blue,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'المهام المكتملة',
                completedTasks.toString(),
                Icons.check_circle,
                Colors.green,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'المهام المتبقية',
                incompleteTasks.toString(),
                Icons.pending_actions,
                Colors.orange,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'نسبة الإنجاز',
                '%$completionPercentage',
                Icons.pie_chart,
                Colors.purple,
              ),
              const SizedBox(height: 32),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'التقدم الإجمالي',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value:
                              totalTasks > 0 ? completedTasks / totalTasks : 0,
                          minHeight: 20,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'أكملت $completedTasks من $totalTasks مهمة',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'إحصائيات المواد',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // تم إزالة Expanded واستخدام ListView مباشرة مع إعدادات التمرير
              ListView.builder(
                shrinkWrap: true, // يخبر القائمة أن تأخذ مساحة محتواها فقط
                physics:
                    const NeverScrollableScrollPhysics(), // لمنع تعارض التمرير مع الصفحة
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  final subjectTasks =
                      tasks.where((t) => t.subjectId == subject.id).toList();
                  final subjectCompleted =
                      subjectTasks.where((t) => t.isCompleted).length;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: subject.color,
                        child: Icon(subject.icon, color: Colors.white),
                      ),
                      title: Text(subject.name),
                      subtitle: Text(
                        '$subjectCompleted من ${subjectTasks.length} مكتملة',
                      ),
                      trailing: Text(
                        subjectTasks.isNotEmpty
                            ? '${(subjectCompleted / subjectTasks.length * 100).toStringAsFixed(0)}%'
                            : '0%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: subject.color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // تم تحديث withOpacity لتجنب التنبيه في الإصدارات الجديدة
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
