import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({
    super.key,
    required this.text,
    required this.boldText,
    required this.router,
  });
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
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(
              text: boldText,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
