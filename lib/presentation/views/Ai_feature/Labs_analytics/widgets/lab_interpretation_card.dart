import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class LabInterpretationCard extends StatelessWidget {
  final String interpretation;

  const LabInterpretationCard({super.key, required this.interpretation});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.primary2,
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
                  'التفسير:',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(interpretation.isNotEmpty ? interpretation : 'لا توجد تفسير'),
          ],
        ),
      ),
    );
  }
}
