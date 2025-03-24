import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineNameSection extends StatelessWidget {
  final String medicineName;
  final String? medicineNameArabic;

  const MedicineNameSection({
    super.key,
    required this.medicineName,
    this.medicineNameArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          medicineName,
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Text(
          'الاسم العربي: ${medicineNameArabic ?? 'غير محدد'}',
          style: TextStyle(fontSize: 18.sp),
        ),
      ],
    );
  }
}
