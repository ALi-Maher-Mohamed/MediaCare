import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabInterpretationCard extends StatelessWidget {
  final String interpretation;

  const LabInterpretationCard({super.key, required this.interpretation});

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
                Icon(Icons.lightbulb,
                    color:
                        Theme.of(context).colorScheme.primary), // لون من الثيم
                SizedBox(width: 8.w),
                Text(
                  'التفسير:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ), // نمط من الثيم
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              interpretation.isNotEmpty ? interpretation : 'لا يوجد تفسير',
              style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
            ),
          ],
        ),
      ),
    );
  }
}
