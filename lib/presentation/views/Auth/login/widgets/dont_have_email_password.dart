import 'package:flutter/material.dart';
import '../../../../../core/utlis/app_color.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText(
      {super.key,
      required this.text,
      required this.boldText,
      required this.router});
  final String text, boldText;
  final Widget router;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return router;
          },
        ));
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(color: AppColors.darkGrey),
            ),
            TextSpan(
              style: TextStyle(color: AppColors.primary),
              text: boldText,
            ),
          ],
        ),
      ),
    );
  }
}
