import 'package:flutter/material.dart';
import 'package:media_care/core/utlis/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      this.suffixIcon,
      this.focusedBorder,
      this.enabledBorder,
      this.hintStyle,
      this.isObscureText,
      this.controller,
      required this.validator,
      this.inputType,
      this.onChanged});
  final String label;
  final TextInputType? inputType;
  final Widget? suffixIcon;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? hintStyle;
  final bool? isObscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        validator: validator,
        keyboardType: inputType ?? TextInputType.text,
        obscureText: isObscureText ?? false,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          label: Text(
            label,
          ),
          labelStyle: hintStyle ??
              TextStyle(
                color: Colors.blueGrey,
                fontSize: 18,
              ),
          suffixIcon: suffixIcon,
          enabledBorder: enabledBorder ?? buldBorder(),
          focusedBorder: focusedBorder ?? buldBorder(),
        ));
  }

  OutlineInputBorder buldBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
