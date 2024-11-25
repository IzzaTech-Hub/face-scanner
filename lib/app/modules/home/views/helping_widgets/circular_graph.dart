import 'package:flutter/material.dart';
import 'dart:math';

var thickness = 25;

class Graph extends StatelessWidget {
  var padsize = 50;
  Color bgcolor = Colors.white.withOpacity(0.9);
  Graph({
    super.key,
    required this.size,
    required this.color,
    required this.progress,
  });

  double size;
  Color color;
  double progress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: size - padsize,
              height: size - padsize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              )),
          CustomPaint(
            size: Size(size - padsize, size - padsize),
            painter:
                CircularProgressPainter(progress: progress, thiscolor: color),
          ),
          Container(
            width: size - padsize,
            height: size - padsize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  // const Color.fromARGB(255, 255, 81, 69),
                  // // const Color.fromARGB(255, 98, 7, 0),
                  // const Color.fromARGB(255, 255, 197, 193),
                  // const Color.fromARGB(255, 255, 81, 69),
                  // const Color.fromARGB(255, 98, 7, 0),
                  Colors.black.withOpacity(0.2),
                  // Colors.transparent,
                  Colors.white.withOpacity(0.3),
                  Colors.black.withOpacity(0.2),
                  // color.bgdark.withOpacity(customopacity),
                  // color.bglight.withOpacity(customopacity),
                  // color.bgdark.withOpacity(customopacity),
                ],
                stops: [0.9, 0.95, 1],
              ),
            ),
          ),
          Center(
            child: Container(
              width: size -
                  padsize -
                  thickness, // Size of the inner circle (smaller to create a border effect)
              height: size - padsize - thickness,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgcolor, // Inner circle background color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  double progress; // Progress value from 0.0 to 1.0
  Color thiscolor;
  CircularProgressPainter({required this.progress, required this.thiscolor});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = thickness / 2; // Thickness of the progress bar

    // Define center and radius for the circle
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - strokeWidth / 2;

    // Background circle (empty progress bar)
    Paint backgroundPaint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded edges for the progress bar

    // Draw the background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Paint for the progress arc
    Paint progressPaint = Paint()
      ..color = thiscolor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded edges for the progress bar

    // Define start angle and sweep angle for the progress arc
    double startAngle = -pi / 2; // Start from the top of the circle
    double sweepAngle =
        2 * pi * progress; // The amount of the circle to be filled

    // Draw the progress arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, progressPaint);

    // Create a path for the inner container
    Paint innerContainerPaint = Paint()
      ..color = Colors.white // Color of the inner container
      ..style = PaintingStyle.fill; // Fill the inner container

    // Define the inner container size
    double innerRadius = radius * 0.8; // Inner radius (80% of the outer radius)

    // Draw the inner container as a filled circle
    canvas.drawCircle(center, innerRadius, innerContainerPaint);
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress; // Repaint if progress changes
  }
}
