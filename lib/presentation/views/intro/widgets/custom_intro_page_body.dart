import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomIntroPageBody extends StatelessWidget {
  const CustomIntroPageBody({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w), // Responsive padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image, height: 200.h), // Responsive image height
          SizedBox(height: 30.h), // Responsive spacing
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 30.sp, // Responsive font size
                ),
          ),
          SizedBox(height: 15.h), // Responsive spacing
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20.sp, // Responsive font size
                ),
          ),
        ],
      ),
    );
  }
}
