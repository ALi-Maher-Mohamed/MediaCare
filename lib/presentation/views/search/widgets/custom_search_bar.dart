import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryLight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
