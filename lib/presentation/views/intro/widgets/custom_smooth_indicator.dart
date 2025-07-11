import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'custom_intro_page.dart';

class CustomSmoothIndicator extends StatelessWidget {
  const CustomSmoothIndicator({
    super.key,
    required this.controller,
    required this.intros,
  });

  final PageController controller;
  final List<CustomIntroPage> intros;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: controller,
        count: intros.length,
        effect: WormEffect(
          spacing: 16.w, // Responsive spacing
          dotColor: Theme.of(context).colorScheme.secondary,
          dotWidth: 10.w, // Responsive dot width
          dotHeight: 10.h, // Responsive dot height
          activeDotColor: Theme.of(context).colorScheme.primary,
        ),
        onDotClicked: (index) {
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}
