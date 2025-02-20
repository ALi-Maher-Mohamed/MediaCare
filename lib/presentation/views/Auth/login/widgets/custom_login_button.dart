import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton(
      {super.key, required this.text, required this.onPresed});
  final Function() onPresed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          fixedSize: WidgetStatePropertyAll(
            Size(300, 60),
          ),
          backgroundColor: WidgetStatePropertyAll(
            AppColors.primary,
          ),
        ),
        onPressed: onPresed,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ));
  }
}
