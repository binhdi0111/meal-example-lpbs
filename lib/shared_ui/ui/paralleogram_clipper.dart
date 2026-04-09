import 'dart:math' as math;
import 'package:flutter/material.dart';

class Parallelogram extends StatelessWidget {

  const Parallelogram({
    super.key,
    required this.base,
    required this.height,
    required this.angleDeg,
    this.color = Colors.blue,
  });
  final double base;
  final double height;
  final double angleDeg;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final angleRad = angleDeg * math.pi / 180;

    // x = h / tan(alpha)
    final x = height / math.tan(angleRad);

    return CustomPaint(
      size: Size(base + x, height), // bounding box
      painter: _ParallelogramPainter(
        base: base,
        height: height,
        x: x,
        color: color,
      ),
    );
  }
}

class _ParallelogramPainter extends CustomPainter {

  _ParallelogramPainter({
    required this.base,
    required this.height,
    required this.x,
    required this.color,
  });
  final double base;
  final double height;
  final double x;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0) // A
      ..lineTo(base, 0) // B
      ..lineTo(base + x, height) // C
      ..lineTo(x, height) // D
      ..close();

    final paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
