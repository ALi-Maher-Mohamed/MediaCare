import 'package:flutter/material.dart';

class ManualInputTextField extends StatelessWidget {
  final TextEditingController controller;

  const ManualInputTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'أدخل الأعراض أو اسم الدواء',
      ),
      maxLines: 3,
    );
  }
}
