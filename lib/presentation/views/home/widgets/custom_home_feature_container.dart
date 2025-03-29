// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeFeatureContainer extends StatelessWidget {
  CustomHomeFeatureContainer({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
  });
  final String image;
  final String text;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              scale: 5,
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
