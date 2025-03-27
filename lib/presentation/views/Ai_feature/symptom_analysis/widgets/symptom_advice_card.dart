import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class SymptomAdviceCard extends StatelessWidget {
  final String? advice;

  const SymptomAdviceCard({super.key, this.advice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  'النصيحة:',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(advice ?? 'لا توجد نصائح'),
          ],
        ),
      ),
    );
  }
}
