import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Lottie.asset(
            'assets/animation/doctorAnimation1.json',
          ),
        ),
        Flexible(
          child: Image.asset(
            'assets/animation/Medicare.png',
          ),
        )
      ],
    );
  }
}
