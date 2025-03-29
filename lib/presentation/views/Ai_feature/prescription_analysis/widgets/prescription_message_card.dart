import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionMessageCard extends StatelessWidget {
  final String? message;

  const PrescriptionMessageCard({super.key, this.message});

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
                Icon(Icons.message,
                    color:
                        Theme.of(context).colorScheme.primary), // لون من الثيم
                SizedBox(width: 8.w),
                Text(
                  'رسالة:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ), // نمط من الثيم
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              message ?? 'لا يوجد رسالة',
              style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
            ),
          ],
        ),
      ),
    );
  }
}
