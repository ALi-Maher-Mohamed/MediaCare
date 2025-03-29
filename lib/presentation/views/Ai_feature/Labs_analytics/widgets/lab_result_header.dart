import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabResultHeader extends StatelessWidget {
  const LabResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.science,
            color: Theme.of(context).colorScheme.primary), // لون من الثيم
        SizedBox(width: 8.w),
        Text(
          'نتائج الاختبارات:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ), // نمط من الثيم
        ),
      ],
    );
  }
}
