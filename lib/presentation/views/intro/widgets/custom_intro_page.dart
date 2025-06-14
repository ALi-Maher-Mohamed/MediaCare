import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomIntroPage extends StatelessWidget {
  const CustomIntroPage({
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
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 30.w), // Responsive padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image, height: 150.h), // Responsive image height
          SizedBox(height: 30.h), // Responsive spacing
          FittedBox(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 30.sp, // Responsive font size
                  ),
            ),
          ),
          SizedBox(height: 15.h), // Responsive spacing
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              subTitle,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20.sp, // Responsive font size
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
