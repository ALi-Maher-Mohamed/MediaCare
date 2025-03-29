import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RobotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RobotAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          Theme.of(context).appBarTheme.backgroundColor, // من الثيم
      elevation: Theme.of(context).appBarTheme.elevation,
      iconTheme:
          Theme.of(context).appBarTheme.iconTheme, // لون الأيقونة من الثيم
      centerTitle: true,
      title: Text(
        'تحليل البيانات',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24.sp,
            ), // نمط النص من الثيم مع تعديل الحجم
      ),
    );
  }
}
