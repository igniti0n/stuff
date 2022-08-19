import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularShadowStepper extends CustomPainter {
  final double strokeWidth;
  final int numberOfDivisions;

  double blur;

  CircularShadowStepper({
    required this.strokeWidth,
    required this.blur,
    required this.numberOfDivisions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path shadowPath = Path();
    final Path indicatorBottomPath = Path();
    final Path indicatorPath = Path();
    final biggestShadowStrokeWidth = strokeWidth * 3.5;
    final middleShadowStrokeWidth = biggestShadowStrokeWidth * 0.54;
    final smallestShadowStrokeWidth = biggestShadowStrokeWidth * 0.4;
    const fullAngle = math.pi * 2;
    const allsteps = 12;
    const stepAngle = fullAngle / allsteps;
    const stepStartingAngleOffset = 4.08;
    const filledStepPercentege = 0.6;

    for (int i = 0; i < 10; i++) {
      // Bottom of the indicator (light grey)
      indicatorBottomPath.arcTo(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
        i * stepAngle - 4.08,
        stepAngle * filledStepPercentege,
        true,
      );
      // Draw shadow and indicator for every collected fragment
      if (i < numberOfDivisions) {
        // Shadow
        shadowPath.arcTo(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          i * stepAngle - stepStartingAngleOffset,
          stepAngle * filledStepPercentege,
          true,
        );
        // Indicator
        indicatorPath.arcTo(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          i * stepAngle - stepStartingAngleOffset,
          stepAngle * filledStepPercentege,
          true,
        );
      }
    }
    // Shadow paints
    final Paint shadowPaint = Paint()
      ..color = Colors.lightBlue.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = biggestShadowStrokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, blur);
    canvas.drawPath(shadowPath, shadowPaint);

    final middleShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = middleShadowStrokeWidth
      ..color = Colors.lightBlue.withOpacity(0.3)
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 0);

    final smallestShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = smallestShadowStrokeWidth
      ..color = Colors.lightBlue.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 0);

    // Indicator paints
    final indicatorBottomPaint = Paint()
      ..color = Colors.lightBlue.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final indicatorPaint = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // drawing shadows
    canvas.drawPath(
      shadowPath,
      shadowPaint,
    );
    canvas.drawPath(
      shadowPath,
      middleShadowPaint,
    );
    canvas.drawPath(
      shadowPath,
      smallestShadowPaint,
    );
    // Drawing the idnicators
    canvas.drawPath(
      indicatorBottomPath,
      indicatorBottomPaint,
    );
    canvas.drawPath(
      indicatorPath,
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
