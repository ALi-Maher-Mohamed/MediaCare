import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.text,
    required this.onPresed,
  });
  final Function() onPresed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          fixedSize: WidgetStatePropertyAll(
            Size(300, 60),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: onPresed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
        ));
  }
}
