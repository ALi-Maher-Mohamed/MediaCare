import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton(
      {super.key, required this.text, required this.onPresed});
  final Function() onPresed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            AppColors.primaryLight,
          ),
        ),
        onPressed: onPresed,
        child: Text(text));
  }
}
