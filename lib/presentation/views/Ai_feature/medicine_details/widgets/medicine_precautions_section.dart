import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicinePrecautionsSection extends StatelessWidget {
  final List<String>? precautions;

  const MedicinePrecautionsSection({super.key, this.precautions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الاحتياطات:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ), // نمط من الثيم
        ),
        SizedBox(height: 8.h),
        if (precautions != null && precautions!.isNotEmpty)
          ...precautions!.map(
            (precaution) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text(
                '• $precaution',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            ),
          )
        else
          Text(
            'لا توجد احتياطات',
            style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
          ),
      ],
    );
  }
}
