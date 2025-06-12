import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldData extends StatelessWidget {
  final String title;
  final String data;
  final IconData icon;

  const FieldData({
    Key? key,
    required this.title,
    required this.data,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24.sp, color: Colors.blueGrey),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blueGrey,
                  )),
              SizedBox(height: 5.h),
              Text(data,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
