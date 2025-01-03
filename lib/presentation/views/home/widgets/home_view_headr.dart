import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Hi Ali !',
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '1 Jan 2025',
          style: TextStyle(
              color: AppColors.primary.withOpacity(.8),
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
