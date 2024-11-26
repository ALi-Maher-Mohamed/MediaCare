import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account?',
            style: TextStyle(color: AppColors.darkGrey),
          ),
          TextSpan(
            style: TextStyle(color: AppColors.primary),
            text: ' Sign Up',
          ),
        ],
      ),
    );
  }
}
