import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'tasks_screen.dart';

// بيانات مؤقتة للأسبوع الثاني (سيتم استبدالها لاحقاً)
final List<Map<String, dynamic>> tempSubjects = [
  {'name': 'الرياضيات', 'icon': Icons.calculate, 'color': Colors.blue},
  {'name': 'العلوم', 'icon': Icons.science, 'color': Colors.green},
  {'name': 'اللغة العربية', 'icon': Icons.menu_book, 'color': Colors.orange},
  {'name': 'اللغة الإنجليزية', 'icon': Icons.translate, 'color': Colors.brown},
  {'name': 'التاريخ', 'icon': Icons.history, 'color': Colors.purple},
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(appName),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.pushNamed(context, '/statistics'),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'موادي الدراسية',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: tempSubjects.length,
              itemBuilder: (context, index) {
                final subject = tempSubjects[index];
                return _buildSubjectCard(context, subject);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TasksScreen(subjectName: subject['name'] as String),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (subject['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                subject['icon'] as IconData,
                color: subject['color'],
                size: 32,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subject['name'] as String,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              '0 مهام متبقية',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
