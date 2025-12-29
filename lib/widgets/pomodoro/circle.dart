import 'dart:math' as math;
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter 
{
  final Color paintColor;
  final double ratio;

  CirclePainter({required this.paintColor, required this.ratio});

  @override
  void paint(Canvas canvas, Size size) 
  {
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    const startAngle = -math.pi/2;
    final sweepAngle = 2*math.pi*ratio;

    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)
   {
    // Return true if the color or other properties change to trigger a repaint
    return oldDelegate is CirclePainter && oldDelegate.paintColor != paintColor;
  }
}
