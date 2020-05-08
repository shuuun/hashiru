import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class DonutGraph extends StatelessWidget {

  final double height;
  final double width;
  final double percentage;
  final Color trackColor;
  final Color completedColor;

  DonutGraph({
    this.height = 300,
    this.width = 300,
    @required this.percentage,
    @required this.trackColor,
    @required this.completedColor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CustomPaint(
        foregroundPainter: DonutGraphPainter(
          trackColor: trackColor,
          completeColor: completedColor,
          completePercente: percentage,
          strokeWidth: 50
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(child: Text('${percentage.toInt()}', style: TextStyle(fontSize: 44),)),
        ),
      ),
    );
  }
}

class DonutGraphPainter extends CustomPainter {
  final Color trackColor;
  final Color completeColor;
  final double completePercente;
  final double strokeWidth;

  DonutGraphPainter({
    this.trackColor,
    this.completeColor,
    this.completePercente,
    this.strokeWidth
  });

  @override
  void paint(Canvas canvas, Size size) {
    final _baseLine = Paint()
      ..color = trackColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    
    final _completedLine = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    
    final _center = Offset(size.width / 2, size.height / 2);
    final _radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(
      _center,
      _radius,
      _baseLine
    );

    final _arcAngle = 2 * pi * (completePercente / 100);

    canvas.drawArc(
      //Rect
      Rect.fromCircle(center: _center, radius: _radius),
      // Start Angle
      -pi / 2,
      // Sweep Angle
      _arcAngle,
      // Use Center
      false,
      // Paint
      _completedLine
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}