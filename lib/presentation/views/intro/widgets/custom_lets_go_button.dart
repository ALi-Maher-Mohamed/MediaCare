import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/zoom_drawer.dart';
import '../../Auth/login/login_view.dart';

class CustomLetsGoButton extends StatelessWidget {
  const CustomLetsGoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
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
            'لنبدا',
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
