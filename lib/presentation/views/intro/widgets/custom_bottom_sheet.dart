import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text_button.dart';
import 'custom_intro_page.dart';
import 'custom_smooth_indicator.dart';

class CustomButomSheet extends StatelessWidget {
  const CustomButomSheet({
    super.key,
    required this.controller,
    required this.intros,
  });

  final PageController controller;
  final List<CustomIntroPage> intros;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
      height: 80.h, // Responsive height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
            onPressed: () {
              controller.jumpToPage(intros.length - 1);
            },
            text: 'تخطي',
          ),
          CustomSmoothIndicator(controller: controller, intros: intros),
          CustomTextButton(
            text: 'التالي',
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
