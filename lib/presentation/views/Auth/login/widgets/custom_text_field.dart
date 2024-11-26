import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.label, this.icon});
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            label: Text(label),
            labelStyle: TextStyle(
              color: Colors.blueGrey,
              fontSize: 18,
            ),
            suffixIcon: icon,
            enabledBorder: buldBorder(),
            focusedBorder: buldBorder()));
  }

  OutlineInputBorder buldBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
