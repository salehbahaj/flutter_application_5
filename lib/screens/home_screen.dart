import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(appName),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'مرحباً في تطبيق منظم المهام الدراسية\n(سيتم إضافة المحتوى لاحقاً)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
