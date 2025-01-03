import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/intro/introduction_page_view.dart';
import 'package:media_care/presentation/views/splash/widgets/splash_screen.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: splashScreen(),
      splashIconSize: 500,
      nextScreen: const IntroView(),
      // duration: 3500,
      // backgroundColor: Colors.white,
    );
  }
}
