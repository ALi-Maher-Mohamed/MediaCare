import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptySpace extends StatelessWidget {
  const EmptySpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 10.h,
      color: Color(0xffF4F7FD),
    );
  }
}
