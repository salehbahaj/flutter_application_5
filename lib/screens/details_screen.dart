import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic task;
  const DetailsScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل المهمة')),
      body: const Center(child: Text('تفاصيل المهمة - قيد التطوير')),
    );
  }
}
