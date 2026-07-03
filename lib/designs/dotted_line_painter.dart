import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final bool isDash;
  final Color? color;

  DottedLinePainter({this.isDash = false, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? Colors.grey.shade300
      ..strokeCap = StrokeCap.round;

    final y = size.height / 2;

    if (isDash) {
      // Dash style (for flight path) - Exactly 3 equal segments
      paint.strokeWidth = 1.7;
      const segmentCount = 3;
      const spaceWidth = 5.0;

      // Calculate individual dash width to fill the available space equally
      final totalSpaceWidth = spaceWidth * (segmentCount - 1);
      final dashWidth = (size.width - totalSpaceWidth) / segmentCount;

      for (int i = 0; i < segmentCount; i++) {
        final startX = i * (dashWidth + spaceWidth);
        canvas.drawLine(
          Offset(startX, y),
          Offset(startX + dashWidth, y),
          paint,
        );
      }
    } else {
      // Dot style (for perforation)
      paint.style = PaintingStyle.fill;
      const dotRadius = 1.2;
      const spacing = 8.0;
      double startX = dotRadius;
      while (startX < size.width) {
        canvas.drawCircle(Offset(startX, y), dotRadius, paint);
        startX += spacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DottedLinePainter oldDelegate) =>
      oldDelegate.isDash != isDash || oldDelegate.color != color;
}
