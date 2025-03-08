import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 40.h,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
