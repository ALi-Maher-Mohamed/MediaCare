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
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        if (indications != null && indications!.isNotEmpty)
          ...indications!.map(
            (ind) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text('• $ind'),
            ),
          )
        else
          const Text('لا توجد استطبابات'),
      ],
    );
  }
}
