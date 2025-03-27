import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class PrescriptionGeneralAdviceCard extends StatelessWidget {
  final Map<String, dynamic> generalAdvice;

  const PrescriptionGeneralAdviceCard({super.key, required this.generalAdvice});

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
                SizedBox(width: 8.h),
                Text(
                  'النصائح العامة:',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            ...generalAdvice.entries.map(
              (entry) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0.h),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
