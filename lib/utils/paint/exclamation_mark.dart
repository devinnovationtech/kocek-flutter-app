import 'package:flutter/material.dart';

class ExclamationMark extends CustomPainter {
  const ExclamationMark(
      {this.firstColor = Colors.black,
      this.firstOutline = Colors.white,
      this.secondColor = Colors.black,
      this.secondOutline = Colors.white});
  final Color firstColor, secondColor, firstOutline, secondOutline;

  @override
  void paint(Canvas canvas, Size size) {
    Path firstPath = Path()
      ..moveTo(size.width * 0.65, 0)
      ..lineTo(size.width * 0.8, 0)
      ..lineTo(size.width * 0.75, size.height * 0.15)
      ..lineTo(size.width * 0.7, size.height * 0.25)
      ..close();

    Path secondPath = Path()
      ..moveTo(size.width, size.height * 0.1)
      ..lineTo(size.width * 0.85, 0)
      ..lineTo(size.width * 0.7, size.height * 0.35)
      ..close();

    Paint fill(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Paint outline(Color color) => Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(firstPath, fill(firstColor));
    canvas.drawPath(firstPath, outline(firstOutline));

    canvas.drawPath(secondPath, fill(secondColor));
    canvas.drawPath(secondPath, outline(secondOutline));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
