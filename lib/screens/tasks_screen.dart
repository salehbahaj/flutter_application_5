import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'add_task_screen.dart';
import 'details_screen.dart';

// بيانات مؤقتة للمهام (للعرض فقط)
final List<Map<String, dynamic>> tempTasks = [
  {
    'title': 'حل تمرين الرياضيات',
    'subject': 'الرياضيات',
    'description': 'الصفحة 42',
    'dueDate': '2026-04-10',
    'priority': 'عالية',
    'isCompleted': false,
  },
  {
    'title': 'كتابة بحث العلوم',
    'subject': 'العلوم',
    'description': 'النظام الشمسي',
    'dueDate': '2026-04-12',
    'priority': 'متوسطة',
    'isCompleted': false,
  },
];

class TasksScreen extends StatefulWidget {
  final String subjectName;
  const TasksScreen({Key? key, required this.subjectName}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _searchQuery = '';
  String _filter = 'الكل';

  List<Map<String, dynamic>> get _filteredTasks {
    var tasks = tempTasks
        .where((t) => t['subject'] == widget.subjectName)
        .toList();
    if (_searchQuery.isNotEmpty) {
      tasks = tasks.where((t) => t['title'].contains(_searchQuery)).toList();
    }
    if (_filter == 'مكتملة') {
      tasks = tasks.where((t) => t['isCompleted'] == true).toList();
    } else if (_filter == 'غير مكتملة') {
      tasks = tasks.where((t) => t['isCompleted'] == false).toList();
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.subjectName),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: _filteredTasks.isEmpty
                ? const Center(child: Text('لا توجد مهام'))
                : ListView.builder(
                    itemCount: _filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = _filteredTasks[index];
                      return TaskCard(
                        task: task,
                        onToggle: () {
                          setState(() {
                            task['isCompleted'] = !task['isCompleted'];
                          });
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(task: task),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'ابحث عن مهمة...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: cardColor,
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['الكل', 'مكتملة', 'غير مكتملة'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: _filter == filter,
              onSelected: (_) => setState(() => _filter = filter),
              backgroundColor: Colors.grey.shade200,
              selectedColor: primaryColor.withOpacity(0.3),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Widget TaskCard (مؤقت للأسبوع الثاني)
class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Checkbox(
                value: task['isCompleted'],
                onChanged: (_) => onToggle(),
                activeColor: primaryColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: task['isCompleted']
                            ? TextDecoration.lineThrough
                            : null,
                        color: task['isCompleted'] ? Colors.grey : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${task['subject']} • ${task['dueDate']}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    if (task['description'].isNotEmpty)
                      Text(
                        task['description'],
                        style: const TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              Icon(
                task['priority'] == 'عالية' ? Icons.flag : Icons.flag_outlined,
                color: task['priority'] == 'عالية' ? Colors.red : Colors.green,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
