import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class PrescriptionDetailsCard extends StatelessWidget {
  final dynamic prescriptionDetails;

  const PrescriptionDetailsCard({super.key, required this.prescriptionDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  'تفاصيل الروشتة:',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text('اسم الطبيب: ${prescriptionDetails.doctorName ?? 'غير محدد'}'),
            Text(
                'اسم المريض: ${prescriptionDetails.patientName ?? 'غير محدد'}'),
            Text('عمر المريض: ${prescriptionDetails.patientAge ?? 'غير محدد'}'),
            Text(
                'تاريخ الروشتة: ${prescriptionDetails.prescriptionDate ?? 'غير محدد'}'),
          ],
        ),
      ),
    );
  }
}
