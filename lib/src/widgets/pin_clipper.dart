import 'package:flutter/material.dart';

class PinClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height);
    path_0.cubicTo(size.width * 0.5000000, size.height, size.width,
        size.height * 0.7272722, size.width, size.height * 0.4090911);
    path_0.cubicTo(
        size.width,
        size.height * 0.3005933,
        size.width * 0.9473222,
        size.height * 0.1965389,
        size.width * 0.8535528,
        size.height * 0.1198200);
    path_0.cubicTo(size.width * 0.7597847, size.height * 0.04310056,
        size.width * 0.6326083, 0, size.width * 0.5000000, 0);
    path_0.cubicTo(
        size.width * 0.3673917,
        0,
        size.width * 0.2402153,
        size.height * 0.04310056,
        size.width * 0.1464472,
        size.height * 0.1198200);
    path_0.cubicTo(size.width * 0.05267847, size.height * 0.1965389, 0,
        size.height * 0.3005933, 0, size.height * 0.4090911);
    path_0.cubicTo(0, size.height * 0.7272722, size.width * 0.5000000,
        size.height, size.width * 0.5000000, size.height);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(PinClipper oldClipper) => false;
}
