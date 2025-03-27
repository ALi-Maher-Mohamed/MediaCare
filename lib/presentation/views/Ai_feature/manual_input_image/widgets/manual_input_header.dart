import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManualInputHeader extends StatelessWidget {
  const ManualInputHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'اكتب هنا:',
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }
}
