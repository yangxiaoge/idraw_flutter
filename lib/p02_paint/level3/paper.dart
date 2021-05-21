import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///运行： flutter run -d edge --target=lib/p02_paint/level3/main.dart
class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawShaderLinear(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void drawShaderLinear(Canvas canvas) {
    final Paint mPaint = new Paint();
    mPaint
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 60
      ..strokeJoin = StrokeJoin.miter;

    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    mPaint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(100/2, 0), colors, pos, TileMode.clamp);
    canvas.drawLine(Offset(0, 100), Offset(200/2, 100), mPaint);

    mPaint.shader = ui.Gradient.linear(Offset(0 + 220.0/2, 0),
        Offset(100/2 + 220.0/2, 0), colors, pos, TileMode.repeated);
    canvas.drawLine(
      Offset(0 + 220.0/2, 100),
      Offset(200/2 + 220.0/2, 100),
      mPaint,
    );

    mPaint.shader = ui.Gradient.linear(Offset(0 + 220.0 * 2/2, 0),
        Offset(100/2 + 220.0 * 2/2, 0), colors, pos, TileMode.mirror);
    canvas.drawLine(
      Offset(0 + 220.0 * 2/2, 100),
      Offset(200/2 + 220.0 * 2/2, 100),
      mPaint,
    );
  }
}
