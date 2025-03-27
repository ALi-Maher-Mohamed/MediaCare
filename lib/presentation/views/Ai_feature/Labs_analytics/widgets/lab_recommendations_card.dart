import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class LabRecommendationsCard extends StatelessWidget {
  final List<String>? recommendations;

  const LabRecommendationsCard({super.key, this.recommendations});

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
                Icon(Icons.recommend, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  'التوصيات:',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            if (recommendations != null && recommendations!.isNotEmpty)
              ...recommendations!.map(
                (rec) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.h),
                  child: Text(rec),
                ),
              )
            else
              const Text('لا توجد توصيات'),
          ],
        ),
      ),
    );
  }
}
