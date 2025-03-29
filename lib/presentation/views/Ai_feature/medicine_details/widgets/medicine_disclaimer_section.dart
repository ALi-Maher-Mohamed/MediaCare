import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineDisclaimerSection extends StatelessWidget {
  final String? disclaimer;

  const MedicineDisclaimerSection({super.key, this.disclaimer});

  @override
  Widget build(BuildContext context) {
    return Text(
      disclaimer ?? 'لا توجد إخلاء مسؤولية',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            fontSize: 14.sp,
          ), // نمط من الثيم مع تعديل
    );
  }
}
