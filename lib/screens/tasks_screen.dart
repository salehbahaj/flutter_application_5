import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../data/dummy_data.dart';
import '../widgets/task_card.dart';
import 'task_details_screen.dart';
import 'task_form_screen.dart';

enum TaskFilter { all, completed, incomplete }

enum TaskSort {
  dateNewest,
  dateOldest,
  titleAZ,
  titleZA,
  priorityHigh,
  priorityLow
}

class TasksScreen extends StatefulWidget {
  final Subject subject;

  const TasksScreen({super.key, required this.subject});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskFilter _currentFilter = TaskFilter.all;
  TaskSort _currentSort = TaskSort.dateNewest;
  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Task> _getFilteredTasks() {
    var subjectTasks =
        tasks.where((t) => t.subjectId == widget.subject.id).toList();

    if (_searchQuery.isNotEmpty) {
      subjectTasks = subjectTasks
          .where(
              (t) => t.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    switch (_currentFilter) {
      case TaskFilter.completed:
        return subjectTasks.where((t) => t.isCompleted).toList();
      case TaskFilter.incomplete:
        return subjectTasks.where((t) => !t.isCompleted).toList();
      case TaskFilter.all:
        break;
    }

    switch (_currentSort) {
      case TaskSort.dateNewest:
        subjectTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case TaskSort.dateOldest:
        subjectTasks.sort((a, b) => b.dueDate.compareTo(a.dueDate));
        break;
      case TaskSort.titleAZ:
        subjectTasks.sort((a, b) => a.title.compareTo(b.title));
        break;
      case TaskSort.titleZA:
        subjectTasks.sort((a, b) => b.title.compareTo(a.title));
        break;
      case TaskSort.priorityHigh:
        subjectTasks
            .sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case TaskSort.priorityLow:
        subjectTasks
            .sort((a, b) => a.priority.index.compareTo(b.priority.index));
        break;
    }

    return subjectTasks;
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _getFilteredTasks();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _isSearching
            ? Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'بحث عن مهمة...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              )
            : Text(widget.subject.name),
        backgroundColor: widget.subject.color,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchQuery = '';
              });
            },
          ),
          PopupMenuButton<TaskSort>(
            icon: const Icon(Icons.sort),
            onSelected: (TaskSort result) {
              setState(() {
                _currentSort = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<TaskSort>>[
              const PopupMenuItem<TaskSort>(
                value: TaskSort.dateNewest,
                child: Text('الأقرب موعداً'),
              ),
              const PopupMenuItem<TaskSort>(
                value: TaskSort.dateOldest,
                child: Text('الأبعد موعداً'),
              ),
              const PopupMenuItem<TaskSort>(
                value: TaskSort.titleAZ,
                child: Text('أبجدي (أ-ي)'),
              ),
              const PopupMenuItem<TaskSort>(
                value: TaskSort.titleZA,
                child: Text('أبجدي (ي-أ)'),
              ),
              const PopupMenuItem<TaskSort>(
                value: TaskSort.priorityHigh,
                child: Text('الأعلى أولوية'),
              ),
              const PopupMenuItem<TaskSort>(
                value: TaskSort.priorityLow,
                child: Text('الأقل أولوية'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskFormScreen(
                subjectId: widget.subject.id,
              ),
            ),
          );
          setState(() {});
        },
        backgroundColor: widget.subject.color,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Filter buttons - MODIFIED TO FIX OVERFLOW
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip('الكل', TaskFilter.all, Icons.list),
                const SizedBox(width: 4),
                _buildFilterChip(
                    'مكتملة', TaskFilter.completed, Icons.check_circle),
                const SizedBox(width: 4),
                _buildFilterChip(
                    'غير مكتملة', TaskFilter.incomplete, Icons.pending),
              ],
            ),
          ),
          Expanded(
            child: filteredTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchQuery.isNotEmpty
                              ? Icons.search_off
                              : Icons.task_alt,
                          size: 100,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'لا توجد نتائج للبحث'
                              : 'أنجزت جميع المهام! 🎉',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskCard(
                        task: task,
                        color: widget.subject.color,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsScreen(
                                task: task,
                                subject: widget.subject,
                              ),
                            ),
                          );
                          setState(() {});
                        },
                        onToggle: () {
                          setState(() {
                            task.isCompleted = !task.isCompleted;
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // UPDATED _buildFilterChip to prevent overflow
  Widget _buildFilterChip(String label, TaskFilter filter, IconData icon) {
    final isSelected = _currentFilter == filter;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: FilterChip(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : widget.subject.color,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _currentFilter = filter;
            });
          },
          selectedColor: widget.subject.color,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          backgroundColor: Colors.grey[200],
          checkmarkColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        ),
      ),
    );
  }
}
