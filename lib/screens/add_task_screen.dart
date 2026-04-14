import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedPriority = 'متوسطة';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 72, 201, 130),
      appBar: AppBar(
        title: const Text('إضافة مهمة جديدة'),
        backgroundColor: const Color.fromARGB(255, 147, 59, 62),
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
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              decoration: const InputDecoration(labelText: 'الأولوية'),
              items: const [
                DropdownMenuItem(value: 'منخفضة', child: Text('منخفضة')),
                DropdownMenuItem(value: 'متوسطة', child: Text('متوسطة')),
                DropdownMenuItem(value: 'عالية', child: Text('عالية')),
              ],
              onChanged: (value) => setState(() => _selectedPriority = value!),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // هنا سيتم حفظ المهمة في التحديث القادم
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('سيتم إضافة المهمة في التحديث القادم'),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
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
}
