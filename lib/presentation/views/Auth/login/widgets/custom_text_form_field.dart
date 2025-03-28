import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';

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
      this.onChanged,
      this.autofillHints,
      });
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
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        autofillHints: autofillHints,
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
          enabledBorder: enabledBorder ?? buildBorder(),
          focusedBorder: focusedBorder ?? buildBorder(),
        ));
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
