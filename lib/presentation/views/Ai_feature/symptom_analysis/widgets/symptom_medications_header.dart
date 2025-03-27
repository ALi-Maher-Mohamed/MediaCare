import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class SymptomMedicationsHeader extends StatelessWidget {
  const SymptomMedicationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.medical_services, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          'الأدوية المقترحة:',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
