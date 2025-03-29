import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SymptomMedicationsHeader extends StatelessWidget {
  const SymptomMedicationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.medical_services,
            color: Theme.of(context).colorScheme.primary), // لون من الثيم
        SizedBox(width: 8.w),
        Text(
          'الأدوية المقترحة:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ), // نمط من الثيم
        ),
      ],
    );
  }
}
