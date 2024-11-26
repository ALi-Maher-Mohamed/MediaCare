import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/intro/widgets/custom_text_button.dart';
import 'package:media_care/presentation/views/intro/widgets/custom_intro_page.dart';
import 'package:media_care/presentation/views/intro/widgets/custom_smooth_indicator.dart';

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
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
              onPressed: () {
                controller.jumpToPage(intros.length - 1);
              },
              text: 'تخطي'),
          CustomSmoothIndicator(controller: controller, intros: intros),
          CustomTextButton(
            text: 'التالي',
            onPressed: () {
              controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
          )
        ],
      ),
    );
  }
}
