import 'package:flutter/material.dart';

class RectangleCurveInClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(0, size.height, 80, size.height);
    path.lineTo(size.width - 50, size.height - 100);
    path.quadraticBezierTo(
        size.width, size.height - 120, size.width - 0, size.height - 200);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;}
}