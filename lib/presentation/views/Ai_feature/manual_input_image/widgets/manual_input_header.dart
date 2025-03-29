import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManualInputHeader extends StatelessWidget {
  const ManualInputHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'اكتب هنا:',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 18.sp,
          ), // نمط من الثيم
    );
  }
}
