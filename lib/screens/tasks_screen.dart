import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';
import '../utils/constants.dart';
import 'add_task_screen.dart';
import 'details_screen.dart';

class TasksScreen extends StatefulWidget {
  final String subject;
  const TasksScreen({Key? key, required this.subject}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _searchQuery = '';
  String _filter = 'الكل';

  List<Task> get _filteredTasks {
    var tasks = dummyTasks.where((t) => t.subject == widget.subject).toList();
    if (_searchQuery.isNotEmpty) {
      tasks = tasks
          .where(
            (t) =>
                t.title.contains(_searchQuery) ||
                t.description.contains(_searchQuery),
          )
          .toList();
    }
    if (_filter == 'مكتملة') {
      tasks = tasks.where((t) => t.isCompleted).toList();
    } else if (_filter == 'غير مكتملة') {
      tasks = tasks.where((t) => !t.isCompleted).toList();
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.subject),
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
                            task.isCompleted = !task.isCompleted;
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
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskScreen(subject: widget.subject),
            ),
          );
          if (result == true) setState(() {});
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
