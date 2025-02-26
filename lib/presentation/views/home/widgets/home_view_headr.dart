import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../../../core/utils/app_color.dart';

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
                width: 130,
                child: Image.asset(
                  'assets/images/Medicare.png',
                  height: 100,
                )),
            IconButton(
              color: AppColors.primary,
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: Icon(Icons.menu),
            ),
          ],
        ),
        Text(
          ' ${DateTime.now().day.toString()} / ${DateTime.now().month.toString()} / ${DateTime.now().year.toString()}',
          style: TextStyle(
              color: AppColors.primary.withOpacity(.8),
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
