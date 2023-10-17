import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:square_percent_indicater/Matrix4.dart';


class SquarePercentIndicatorWidget extends StatefulWidget {
  final double width;
  final double height;
  final double progress;

  ///square border radius
  final double borderRadius;
  final Color progressColor;
  final Color shadowColor;

  ///thickness of the progress
  final double progressWidth;
  final double shadowWidth;
  final Widget? child;

  ///if true the progress is moving clockwise
   bool reverse;

  final StartAngle startAngle;

   SquarePercentIndicatorWidget(
      {
        this.progress = 0.0,
        this.reverse = false,
        this.borderRadius = 5,
        this.progressColor = Colors.blue,
        this.shadowColor = Colors.grey,
        this.progressWidth = 5,
        this.shadowWidth = 5,
        this.child,
        this.startAngle=StartAngle.topLeft,
        this.width = 150,
        this.height = 150});

  @override
  State<SquarePercentIndicatorWidget> createState() => _SquarePercentIndicatorState();
}

class _SquarePercentIndicatorState extends State<SquarePercentIndicatorWidget> {

  int value = 0;
  late Timer timer1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.reverse==true?CustomPaint(
          child: widget.child ?? Container(),
          painter:RadialPainter(
              startAngle: widget.startAngle,
              progress: widget.progress,
              color: widget.progressColor,
              shadowColor: widget.shadowColor,
             // reverse: widget.reverse,
              strokeCap: StrokeCap.round,
              paintingStyle: PaintingStyle.stroke,
              strokeWidth: widget.progressWidth,
              shadowWidth: widget.shadowWidth,
              borderRadius: widget.borderRadius),
        ):Container(child: widget.child),

    );
  }
}

class RadialPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color shadowColor;
  final StrokeCap strokeCap;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double shadowWidth;
  final double borderRadius;
  final bool reverse;
  final StartAngle startAngle;

  RadialPainter({
    required this.progress,
    this.color=Colors.blue,
    this.shadowColor=Colors.grey,
    this.strokeWidth=4,
    this.shadowWidth=1,
    this.reverse=false,
    required this.strokeCap,
    required this.paintingStyle,
    this.startAngle = StartAngle.topLeft,
    this.borderRadius = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    Paint shadowPaint = Paint()
      ..strokeWidth = shadowWidth
      ..color = shadowColor
      ..style = paintingStyle
      ..strokeCap = strokeCap;

    var path = Path();
    Path dashPath = Path();

    path.moveTo(borderRadius, 0);
    path.lineTo(size.width - borderRadius, 0);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(size.width - borderRadius, borderRadius),
            radius: borderRadius),
        -pi / 2,
        pi / 2,
        false);
    path.lineTo(size.width, size.height - borderRadius);
    path.arcTo(
        Rect.fromCircle(
            center:
            Offset(size.width - borderRadius, size.height - borderRadius),
            radius: borderRadius),
        0,
        pi / 2,
        false);
    path.lineTo(0 + borderRadius, size.height);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(borderRadius, size.height - borderRadius),
            radius: borderRadius),
        pi / 2,
        pi / 2,
        false);
    path.lineTo(0, borderRadius);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(borderRadius, borderRadius), radius: borderRadius),
        pi,
        pi / 2,
        false);

    for (PathMetric pathMetric in path.computeMetrics()) {
      dashPath.addPath(
        pathMetric.extractPath(0, pathMetric.length * progress),
        Offset.zero,
      );
    }

    if (reverse) {
      dashPath = dashPath
          .transform(Matrix4Transform().rotate(pi / 2).m.storage)
          .transform(Matrix4Transform().flipHorizontally().m.storage);
    }

    dashPath = dashPath.transform(
        Matrix4Transform().rotateByCenter(startAngle.value, size).m.storage);

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum StartAngle { topRight, topLeft, bottomRight, bottomLeft }

extension GetValue on StartAngle {
  double get value => getRotationAngle;

  double get getRotationAngle {
    switch (this) {
      case StartAngle.topLeft:
        return 0;
      case StartAngle.topRight:
        return pi * 0.5;
      case StartAngle.bottomRight:
        return pi * 1.0;
      case StartAngle.bottomLeft:
        return pi * 1.5;
      default:
        return 0;
    }
  }
}
