import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabRecommendationsCard extends StatelessWidget {
  final List<String>? recommendations;

  const LabRecommendationsCard({super.key, this.recommendations});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface, // خلفية من الثيم
      surfaceTintColor:
          Theme.of(context).colorScheme.primary, // لون التمييز من الثيم
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.recommend,
                    color:
                        Theme.of(context).colorScheme.primary), // لون من الثيم
                SizedBox(width: 8.w),
                Text(
                  'التوصيات:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ), // نمط من الثيم
                ),
              ],
            ),
            SizedBox(height: 10.h),
            if (recommendations != null && recommendations!.isNotEmpty)
              ...recommendations!.map(
                (rec) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.h),
                  child: Text(
                    rec,
                    style:
                        Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
                  ),
                ),
              )
            else
              Text(
                'لا توجد توصيات',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
          ],
        ),
      ),
    );
  }
}
