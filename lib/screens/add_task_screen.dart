import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final String subject;
  const AddTaskScreen({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة مهمة')),
      body: const Center(child: Text('نموذج إضافة مهمة - قيد التطوير')),
    );
  }
}
