import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestResultCard extends StatelessWidget {
  final int index;
  final dynamic test;

  const LabTestResultCard({super.key, required this.index, required this.test});

  @override
  Widget build(BuildContext context) {
    final isAbnormal = (test.status?.toLowerCase() == 'غير طبيعي');
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.surface, // خلفية من الثيم
      surfaceTintColor:
          Theme.of(context).colorScheme.primary, // لون التمييز من الثيم
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختبار ${index + 1}: ${test.name ?? 'غير محدد'}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 14.sp,
                  ), // نمط من الثيم
            ),
            SizedBox(height: 5.h),
            Text(
              'القيمة: ${test.value ?? 'غير محدد'}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18.sp,
                  ), // نمط من الثيم
            ),
            Text(
              'الوحدة: ${test.unit ?? 'غير محدد'}',
              style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
            ),
            Text(
              'الحالة: ${test.status ?? 'غير محدد'}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isAbnormal ? Colors.redAccent : Colors.green,
                  ), // نمط من الثيم مع لون مشروط
            ),
            Text(
              'ملاحظات: ${test.notes ?? 'لا توجد ملاحظات'}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isAbnormal ? Colors.redAccent : Colors.green,
                  ), // نمط من الثيم مع لون مشروط
            ),
          ],
        ),
      ),
    );
  }
}
