import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:media_care/presentation/views/home/home_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Lottie.asset(
              'assets/animation/doctorAnimation.json',
            ),
          ),
          Flexible(
            child: Image.asset(
              'assets/animation/mediLogo.png',
            ),
          )
        ],
      ),
      splashIconSize: 500,
      nextScreen: const HomeView(),
      // duration: 3500,
      // backgroundColor: Colors.white,
    );
  }
}
