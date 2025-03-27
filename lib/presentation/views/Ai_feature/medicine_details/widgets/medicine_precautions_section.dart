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
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        if (precautions != null && precautions!.isNotEmpty)
          ...precautions!.map(
            (precaution) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text('• $precaution'),
            ),
          )
        else
          const Text('لا توجد احتياطات'),
      ],
    );
  }
}
