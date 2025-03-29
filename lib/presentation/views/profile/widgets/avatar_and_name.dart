import 'package:flutter/material.dart';

class AvatarAndName extends StatelessWidget {
  AvatarAndName({required this.name, required this.image, super.key});
  final String? name;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 175,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 63,
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('$image'),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '$name',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ],
    );
  }
}
