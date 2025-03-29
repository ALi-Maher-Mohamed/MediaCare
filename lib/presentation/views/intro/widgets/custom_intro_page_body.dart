import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image, height: 200),
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
