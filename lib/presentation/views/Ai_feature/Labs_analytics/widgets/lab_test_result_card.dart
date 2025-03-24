import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class LabTestResultCard extends StatelessWidget {
  final int index;
  final dynamic test;

  const LabTestResultCard({super.key, required this.index, required this.test});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.primary2,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختبار ${index + 1}: ${test.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            SizedBox(height: 5.h),
            Text(
              'القيمة: ${test.value}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            Text('الوحدة: ${test.unit}'),
            Text(
              'الحالة: ${test.status}',
              style: TextStyle(
                color: (test.status?.toLowerCase() == 'غير طبيعي')
                    ? Colors.redAccent
                    : Colors.green,
              ),
            ),
            Text(
              'ملاحظات: ${test.notes}',
              style: TextStyle(
                color: (test.status?.toLowerCase() == 'غير طبيعي')
                    ? Colors.redAccent
                    : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
