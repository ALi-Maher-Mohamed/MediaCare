import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class SymptomConfidenceScoreCard extends StatelessWidget {
  final double? confidenceScore;

  const SymptomConfidenceScoreCard({super.key, this.confidenceScore});

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
                Icon(Icons.score, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  'درجة الثقة:',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text('${confidenceScore ?? 0}%'),
          ],
        ),
      ),
    );
  }
}
