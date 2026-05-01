import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../data/dummy_data.dart';
import '../widgets/subject_card.dart';
import 'tasks_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleDarkMode;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onToggleDarkMode,
    required this.isDarkMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addNewSubject(String name, Color color, IconData icon) {
    setState(() {
      subjects.add(Subject(
        id: DateTime.now().toString(),
        name: name,
        color: color,
        icon: icon,
      ));
    });
  }

  void _showAddSubjectDialog() {
    final nameController = TextEditingController();
    Color selectedColor = Colors.blue;
    IconData selectedIcon = Icons.book;

    final List<Color> colorOptions = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo
    ];

    final List<IconData> iconOptions = [
      Icons.book,
      Icons.school,
      Icons.menu_book,
      Icons.calculate,
      Icons.science,
      Icons.code,
      Icons.language,
      Icons.history,
      Icons.art_track,
      Icons.music_note
    ];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('إضافة مادة جديدة'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'اسم المادة',
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),
                  const Text('اختر اللون:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: colorOptions.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setStateDialog(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selectedColor == color
                                ? Border.all(color: Colors.black, width: 3)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('اختر الأيقونة:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: iconOptions.map((icon) {
                      return GestureDetector(
                        onTap: () {
                          setStateDialog(() {
                            selectedIcon = icon;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedIcon == icon
                                ? Colors.grey[300]
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, size: 32, color: selectedColor),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isNotEmpty) {
                    _addNewSubject(
                      nameController.text.trim(),
                      selectedColor,
                      selectedIcon,
                    );
                    Navigator.pop(ctx);
                  } else {
                    ScaffoldMessenger.of(ctx).showSnackBar(
                      const SnackBar(content: Text('الرجاء إدخال اسم المادة')),
                    );
                  }
                },
                child: const Text('إضافة'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('مدير المهام الدراسية'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleDarkMode,
            tooltip: widget.isDarkMode ? 'الوضع الفاتح' : 'الوضع الليلي',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
            tooltip: 'الإحصائيات',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85, // جعل البطاقة أقل ارتفاعاً (أصغر)
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            final subjectTasks =
                tasks.where((t) => t.subjectId == subject.id).toList();

            return SubjectCard(
              subject: subject,
              taskCount: subjectTasks.length,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TasksScreen(subject: subject),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSubjectDialog,
        tooltip: 'إضافة مادة',
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 3, 115, 195),
      ),
    );
  }
}
