import 'package:flutter/material.dart';
import 'package:media_care/core/utils/app_color.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AppColors.primary,
    ));
  }
}
