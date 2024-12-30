import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:media_care/presentation/views/intro/introduction_page_view.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
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
      ),
      splashIconSize: 500,
      nextScreen: const IntroView(),
      // duration: 3500,
      // backgroundColor: Colors.white,
    );
  }
}
