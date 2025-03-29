import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineAdditionalInfoSection extends StatelessWidget {
  final List<String>? additionalInformation;

  const MedicineAdditionalInfoSection({super.key, this.additionalInformation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'معلومات إضافية:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20.sp,
              ), // نمط من الثيم
        ),
        SizedBox(height: 8.h),
        if (additionalInformation != null && additionalInformation!.isNotEmpty)
          ...additionalInformation!.map(
            (info) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0.h),
              child: Text(
                '• $info',
                style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
              ),
            ),
          )
        else
          Text(
            'لا توجد معلومات إضافية',
            style: Theme.of(context).textTheme.bodyLarge, // نمط من الثيم
          ),
      ],
    );
  }
}
