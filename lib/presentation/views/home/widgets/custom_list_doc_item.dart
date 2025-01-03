import 'package:flutter/material.dart';

import '../../../../core/utlis/app_color.dart';

class CustomDocListViewItem extends StatelessWidget {
  const CustomDocListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/doc0.png',
            height: 150,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                'Ali maher',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Therapist ', style: TextStyle()),
            ],
          ),
        ],
      ),
    );
  }
}
