import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'package:media_care/presentation/views/intro/widgets/custom_intro_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
            spacing: 16,
            dotColor: Colors.grey,
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: AppColors.primary),
        onDotClicked: (index) {
          controller.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        },
      ),
    );
  }
}
