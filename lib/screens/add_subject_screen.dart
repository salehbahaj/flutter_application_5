import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/subject_model.dart';
import '../utils/constants.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  IconData _selectedIcon = Icons.book;
  Color _selectedColor = primaryColor;

  final List<IconData> _icons = [
    Icons.calculate,
    Icons.science,
    Icons.menu_book,
    Icons.translate,
    Icons.history,
    Icons.art_track,
    Icons.sports_soccer,
    Icons.music_note,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('إضافة مادة جديدة'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'اسم المادة'),
              validator: (v) => v!.isEmpty ? 'الرجاء إدخال اسم المادة' : null,
            ),
            const SizedBox(height: 20),
            const Text(
              'اختر أيقونة:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 16,
              children: _icons
                  .map(
                    (icon) => GestureDetector(
                      onTap: () => setState(() => _selectedIcon = icon),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _selectedIcon == icon
                              ? primaryColor
                              : Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: _selectedIcon == icon
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'اختر لون:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 16,
              children:
                  [
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.purple,
                        Colors.red,
                        Colors.teal,
                        Colors.pink,
                        Colors.indigo,
                      ]
                      .map(
                        (color) => GestureDetector(
                          onTap: () => setState(() => _selectedColor = color),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: color,
                            child: _selectedColor == color
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _addSubject,
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text(
                'إضافة المادة',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addSubject() {
    if (_formKey.currentState!.validate()) {
      final newSubject = Subject(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        icon: _selectedIcon,
        color: _selectedColor,
      );
      subjects.add(newSubject);
      Navigator.pop(context, true);
    }
  }
}
