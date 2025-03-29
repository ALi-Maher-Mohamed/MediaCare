import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineIndicationsSection extends StatelessWidget {
  final List<String>? indications;

  const MedicineIndicationsSection({super.key, this.indications});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الاستطبابات:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ), // نمط من الثيم
        ),
        SizedBox(height: 8.h),
        if (indications != null && indications!.isNotEmpty)
          ...indications!.map(
            (ind) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text(
                '• $ind',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            ),
          )
        else
          Text(
            'لا توجد استطبابات',
            style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
          ),
      ],
    );
  }
}
