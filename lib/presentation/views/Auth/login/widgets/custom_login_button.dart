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
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          fixedSize: MaterialStatePropertyAll(
            Size(300, 60),
          ),
          backgroundColor: MaterialStatePropertyAll(
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
