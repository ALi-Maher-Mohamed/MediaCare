import 'package:flutter/material.dart';
import 'package:media_care/core/utils/app_color.dart';

class TitleAndSeeAll extends StatelessWidget {
  const TitleAndSeeAll({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'المزيد',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary),
            ),
          )
        ],
      ),
    );
  }
}
