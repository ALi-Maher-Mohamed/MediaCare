import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineDosageSection extends StatelessWidget {
  final String? dosageInstructions;

  const MedicineDosageSection({super.key, this.dosageInstructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تعليمات الجرعة:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ), // نمط من الثيم
        ),
        SizedBox(height: 8.h),
        Text(
          dosageInstructions ?? 'غير محدد',
          style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
        ),
      ],
    );
  }
}
