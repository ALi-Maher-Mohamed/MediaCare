import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        children: [
          Text(
            '... مرحبا بك ',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          Text(
            'سجل دخولك ',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
