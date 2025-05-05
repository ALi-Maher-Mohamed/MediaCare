import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 130.w,
              child: Image.asset(
                'assets/images/Medicare.png',
                height: 80.h,
              ),
            ),
            IconButton(
              color: Theme.of(context).primaryColor, // بالفعل بيتبع الـ Theme
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: Icon(Icons.menu),
            ),
          ],
        ),
        Text(
          ' ${DateTime.now().day.toString()} / ${DateTime.now().month.toString()} / ${DateTime.now().year.toString()}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).primaryColor.withOpacity(.8),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ), // بالفعل بيتبع الـ Theme
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
