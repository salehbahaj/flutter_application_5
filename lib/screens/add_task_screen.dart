import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_data.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

class AddTaskScreen extends StatefulWidget {
  final String subject;
  const AddTaskScreen({Key? key, required this.subject}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Priority _selectedPriority = Priority.medium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('إضافة مهمة جديدة'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'عنوان المهمة'),
              validator: (v) => v!.isEmpty ? 'الرجاء إدخال عنوان' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'الوصف'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('تاريخ الاستحقاق'),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (picked != null) setState(() => _selectedDate = picked);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Priority>(
              value: _selectedPriority,
              decoration: const InputDecoration(labelText: 'الأولوية'),
              items: const [
                DropdownMenuItem(value: Priority.low, child: Text('منخفضة')),
                DropdownMenuItem(value: Priority.medium, child: Text('متوسطة')),
                DropdownMenuItem(value: Priority.high, child: Text('عالية')),
              ],
              onChanged: (value) => setState(() => _selectedPriority = value!),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text(
                'إضافة المهمة',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        subject: widget.subject,
        dueDate: _selectedDate,
        priority: _selectedPriority,
      );
      dummyTasks.add(newTask);
      Navigator.pop(context, true);
    }
  }
}
