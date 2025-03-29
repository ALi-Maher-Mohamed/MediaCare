import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineSideEffectsSection extends StatelessWidget {
  final List<String>? sideEffects;

  const MedicineSideEffectsSection({super.key, this.sideEffects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الآثار الجانبية:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ), // نمط من الثيم
        ),
        SizedBox(height: 8.h),
        if (sideEffects != null && sideEffects!.isNotEmpty)
          ...sideEffects!.map(
            (effect) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text(
                '• $effect',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            ),
          )
        else
          Text(
            'لا توجد آثار جانبية',
            style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
          ),
      ],
    );
  }
}
