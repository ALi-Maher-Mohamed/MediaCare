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
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        if (sideEffects != null && sideEffects!.isNotEmpty)
          ...sideEffects!.map(
            (effect) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text('• $effect'),
            ),
          )
        else
          const Text('لا توجد آثار جانبية'),
      ],
    );
  }
}
