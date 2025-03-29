import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'ابحث باسم الدكتور او بالتخصص',
            hintTextDirection: TextDirection.rtl,
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
