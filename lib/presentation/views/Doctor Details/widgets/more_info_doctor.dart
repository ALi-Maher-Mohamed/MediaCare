import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreInfoDoctor extends StatelessWidget {
  final String? moreInfoAboutDoctor;
  MoreInfoDoctor({
    required this.moreInfoAboutDoctor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(16), // هامش خارجي
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            // offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        collapsedIconColor: Color(0xff0DCAF0),
        iconColor: Color(0xff0DCAF0),
        dense: true,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FaIcon(
                FontAwesomeIcons.circleInfo,
                size: 18,
                color: Color(0xff0DCAF0),
              ),
            ),
            Text(
              'معلومات عن الدكتور',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$moreInfoAboutDoctor',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
