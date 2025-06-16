import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/zoom_drawer.dart';

class CustomLetsGoButton extends StatelessWidget {
  const CustomLetsGoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await SharedPreference().setHasSeenOnboarding();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      },
      child: Container(
        height: 70.h, // Responsive height
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h), // Responsive padding
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(
            'لنبدأ',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 24.sp, // Responsive font size
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }
}
