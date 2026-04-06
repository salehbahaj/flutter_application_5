import 'package:flutter/material.dart';

class AddSubjectScreen extends StatelessWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة مادة')),
      body: const Center(child: Text('إضافة مادة - قيد التطوير')),
    );
  }
}
