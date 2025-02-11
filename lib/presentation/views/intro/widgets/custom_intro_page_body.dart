import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utlis/app_color.dart';

class CustomIntroPageBody extends StatelessWidget {
  const CustomIntroPageBody(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});
  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 200,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 30,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
