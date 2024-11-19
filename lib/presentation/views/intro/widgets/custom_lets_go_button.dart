import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';
import 'package:media_care/presentation/views/home/home_view.dart';

class CustomLetsGoButton extends StatelessWidget {
  const CustomLetsGoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ));
      },
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.primary),
        child: Center(
          child: Text(
            'لنبدا',
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
