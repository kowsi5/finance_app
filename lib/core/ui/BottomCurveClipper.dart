import 'package:flutter/cupertino.dart';

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);

    // Create a curved line
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point and end point
      size.width, size.height - 20,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 10); // Left bottom corner
    path.lineTo(size.width, size.height - 10); // Right bottom corner
    path.lineTo(size.width, 20); // Right top corner
    path.quadraticBezierTo(size.width / 2, 0, 0, 20); // Curve
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
