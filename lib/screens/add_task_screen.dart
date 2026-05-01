import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../data/dummy_data.dart';

class AddTaskScreen extends StatefulWidget {
  final Subject subject;

  const AddTaskScreen({super.key, required this.subject});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TaskPriority priority = TaskPriority.medium;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('ar', 'SA'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void saveTask() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال عنوان المهمة')),
      );
      return;
    }
    tasks.add(Task(
      id: DateTime.now().toString(),
      subjectId: widget.subject.id,
      title: titleController.text,
      description: descController.text,
      dueDate: selectedDate,
      priority: priority,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة مهمة'),
        backgroundColor: widget.subject.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'العنوان'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'الوصف'),
              ),
              ListTile(
                title: const Text('تاريخ الاستحقاق'),
                subtitle: Text(
                    '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              DropdownButton<TaskPriority>(
                value: priority,
                isExpanded: true,
                items: TaskPriority.values.map((p) {
                  return DropdownMenuItem(
                    value: p,
                    child: Text(p.name),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() => priority = val!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.subject.color,
                ),
                child: const Text('حفظ'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
