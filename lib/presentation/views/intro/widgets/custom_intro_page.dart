import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:media_care/core/utlis/app_color.dart';

class CustomIntroPage extends StatelessWidget {
  const CustomIntroPage(
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
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image, height: 150),
            SizedBox(
              height: 30,
            ),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                subTitle,
                style: TextStyle(
                    // fontSize: 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
