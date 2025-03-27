import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class LabResultHeader extends StatelessWidget {
  const LabResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.science, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          'نتائج الاختبارات:',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
