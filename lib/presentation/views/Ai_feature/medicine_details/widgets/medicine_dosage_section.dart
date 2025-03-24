import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineDosageSection extends StatelessWidget {
  final String? dosageInstructions;

  const MedicineDosageSection({super.key, this.dosageInstructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تعليمات الجرعة:',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        Text(dosageInstructions ?? 'غير محدد'),
      ],
    );
  }
}
