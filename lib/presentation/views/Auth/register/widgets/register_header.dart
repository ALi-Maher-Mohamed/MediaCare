import 'package:flutter/material.dart';

import '../../../../../core/utils/app_color.dart';

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
            style: TextStyle(
              fontSize: 30,
              color: AppColors.primary,
            ),
          ),
          Text(
            'سجل دخولك ',
            style: TextStyle(
              fontSize: 30,
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
