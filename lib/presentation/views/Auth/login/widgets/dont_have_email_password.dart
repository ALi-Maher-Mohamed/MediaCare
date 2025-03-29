import 'package:flutter/material.dart';

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
            ),
            TextSpan(
              text: boldText,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
