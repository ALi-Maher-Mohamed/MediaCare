import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchTextFeild extends StatelessWidget {
  const CustomSearchTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          enabledBorder: buildOutlinedInputBorder(),
          focusedBorder: buildOutlinedInputBorder(),
          hintText: 'Search ...',
          suffixIcon: const Opacity(
            opacity: .7,
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 22,
            ),
          )),
    );
  }

  OutlineInputBorder buildOutlinedInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.white,
        ));
  }
}
