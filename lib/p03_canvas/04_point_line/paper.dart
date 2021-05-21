import 'dart:ui';

import 'package:flutter/material.dart';

///运行： flutter run --target=lib/p03_canvas/04_point_line/main.dart

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;
  late Paint _gridPint;
  final double step = 20;
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final List<Offset> points = [
    Offset(-120, -20),
    Offset(-80, -80),
    Offset(-40, -40),
    Offset(0, -100),
    Offset(40, -120),
    Offset(80, -140),
    Offset(120, -100),
  ];

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.grey;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    //画网格
    _drawGrid(canvas, size);

    //绘点
    _drawPointsWithPoints(canvas);
    //划线（线段模式下：每两个点一对形成线段。如果点是奇数个，那么最后一个点将没有用。）
    _drawPointsWithLines(canvas);
    //多边形连线模式
    _drawPointLineWithPolygon(canvas);

    //画坐标系
    _drawAxis(canvas, size);


  }

  void _drawAxis(Canvas canvas, Size size) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    canvas.drawLine(
        Offset(0, size.height / 2), Offset(0, -size.height / 2), _paint);
    canvas.drawLine(
        Offset(-10, size.height / 2 - 15), Offset(0, size.height / 2), _paint);
    canvas.drawLine(
        Offset(10, size.height / 2 - 15), Offset(0, size.height / 2), _paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(-size.width / 2, 0), _paint);
    canvas.drawLine(
        Offset(size.width / 2 - 15, -10), Offset(size.width / 2, 0), _paint);
    canvas.drawLine(
        Offset(size.width / 2 - 15, 10), Offset(size.width / 2, 0), _paint);
  }

  void _drawPointLineWithPolygon(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, points, _paint);
  }

  void _drawPointsWithLines(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.lines, points, _paint);
  }

  void _drawPointsWithPoints(Canvas canvas) {
    _paint
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, points, _paint);
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
