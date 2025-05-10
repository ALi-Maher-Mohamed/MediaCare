import 'package:flutter/material.dart';

class ManualInputTextField extends StatelessWidget {
  final TextEditingController controller;
  const ManualInputTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary, // لون الحدود من الثيم
          ),
        ),
        hintText: 'أدخل الأعراض أو اسم الدواء',
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
      ),
      maxLines: 3,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
