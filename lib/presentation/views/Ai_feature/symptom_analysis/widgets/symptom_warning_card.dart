import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SymptomWarningCard extends StatelessWidget {
  final String? warning;

  const SymptomWarningCard({super.key, this.warning});

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
                Icon(Icons.warning, color: Colors.redAccent),
                SizedBox(width: 8.w),
                Text(
                  'تحذير:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ), // نمط من الثيم
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              warning ?? 'لا يوجد تحذير',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.redAccent), // نمط من الثيم مع لون مخصص
            ),
          ],
        ),
      ),
    );
  }
}
