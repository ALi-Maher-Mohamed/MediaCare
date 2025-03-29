import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreInfoDoctor extends StatelessWidget {
  final String? moreInfoAboutDoctor;

  const MoreInfoDoctor({
    required this.moreInfoAboutDoctor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ExpansionTile(
        collapsedIconColor: Theme.of(context).colorScheme.primary,
        iconColor: Theme.of(context).colorScheme.primary,
        dense: true,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FaIcon(
                FontAwesomeIcons.circleInfo,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'معلومات عن الدكتور',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$moreInfoAboutDoctor',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
