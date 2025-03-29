import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionGeneralAdviceCard extends StatelessWidget {
  final Map<String, dynamic> generalAdvice;

  const PrescriptionGeneralAdviceCard({super.key, required this.generalAdvice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface, // خلفية من الثيم
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb,
                    color:
                        Theme.of(context).colorScheme.primary), // لون من الثيم
                SizedBox(width: 8.w),
                Text(
                  'النصائح العامة:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ), // نمط من الثيم
                ),
              ],
            ),
            SizedBox(height: 10.h),
            ...generalAdvice.entries.map(
              (entry) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0.h),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
