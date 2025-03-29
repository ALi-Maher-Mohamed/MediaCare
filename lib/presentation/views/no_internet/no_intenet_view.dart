import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/server_down.svg',
          height: 200,
        ),
        SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Please check your internet connection and try again ...',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 22, color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
