import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  var path = Path();
  @override
  Path getClip(Size size) {
    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(size.width * 0.05, size.height - 75, size.width * .5,
        size.height - 100);
    path.quadraticBezierTo(
        size.width * 0.8, size.height - 100, size.width, size.height - 100);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
