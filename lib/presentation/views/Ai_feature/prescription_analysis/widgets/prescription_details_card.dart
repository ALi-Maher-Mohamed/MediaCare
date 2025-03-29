import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionDetailsCard extends StatelessWidget {
  final dynamic prescriptionDetails;

  const PrescriptionDetailsCard({super.key, required this.prescriptionDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 8.w),
                Text(
                  'تفاصيل الروشتة:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              'اسم الطبيب: ${prescriptionDetails.doctorName ?? 'غير واضح'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'اسم المريض: ${prescriptionDetails.patientName ?? 'غير واضح'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'عمر المريض: ${prescriptionDetails.patientAge ?? 'غير واضح'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'تاريخ الروشتة: ${prescriptionDetails.prescriptionDate ?? 'غير واضح'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
