import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idraw_flutter/widget/grid_paper.dart';

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

  PaperPainter() {
    _paint = new Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    //画网格
    MyGridPaper.drawGrid(canvas, size, withAxis: false);

    //绘制矩形 drawRect
    // _drawRect(canvas);
    //绘制圆角矩形 drawRRect
    // _drawRRect(canvas);
    //绘制两个圆角矩形差域 drawDRRect
    // _drawDRRect(canvas);
    //绘制类圆 drawCircle,drawOval,drawArc
    // _drawFill(canvas);
    //小尝试_drawArcDetail
    _drawArcDetail(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawRect(Canvas canvas) {
    _paint..color = Colors.blue;

    //【1】.矩形中心构造
    Rect rectCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectCenter, _paint);

    //【2】.矩形左上右下构造
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, _paint..color = Colors.red);

    //【3】. 矩形左上宽高构造
    Rect rectLTWH = Rect.fromLTWH(-120, 80, 40, 40);
    canvas.drawRect(rectLTWH, _paint..color = Colors.orange);

    //【4】. 矩形内切圆构造
    Rect rectCircle = Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(rectCircle, _paint..color = Colors.green);

    //【5】. 矩形两点构造
    Rect rectPoints = Rect.fromPoints(Offset(80, -80), Offset(120, -120));
    canvas.drawRect(rectPoints, _paint..color = Colors.purple);
  }

  void _drawRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    //【1】.圆角矩形fromRectXY构造
    Rect rectCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    //圆角是一个四分之一椭圆
    canvas.drawRRect(RRect.fromRectXY(rectCenter, 40, 10), _paint);

    //【2】.圆角矩形fromLTRBXY构造
    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10),
        _paint..color = Colors.red);

    //【3】. 圆角矩形fromLTRBR构造
    canvas.drawRRect(RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(10)),
        _paint..color = Colors.orange);

    //【4】. 圆角矩形fromLTRBAndCorners构造
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(80, 80, 120, 120,
            bottomRight: Radius.elliptical(10, 10)),
        _paint..color = Colors.green);

    //【5】. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRRect(
        RRect.fromRectAndCorners(rectFromPoints,
            bottomLeft: Radius.elliptical(10, 10)),
        _paint..color = Colors.purple);
  }

  void _drawDRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    RRect outer = RRect.fromLTRBR(-80, -80, 80, 80, Radius.circular(20));
    RRect inner = RRect.fromLTRBR(-60, -60, 60, 60, Radius.circular(20));
    canvas.drawDRRect(outer, inner, _paint);

    RRect outer2 = RRect.fromLTRBR(-40, -40, 40, 40, Radius.circular(100));
    RRect inner2 = RRect.fromLTRBR(-20, -20, 20, 20, Radius.circular(10));
    canvas.drawDRRect(outer2, inner2, _paint..color = Colors.orange);
  }

  void _drawFill(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.save();
    canvas.translate(-180, 0);

    canvas.drawCircle(Offset(0, 0), 60, _paint);
    canvas.restore();

    var rectOval =
        Rect.fromCenter(center: Offset(0, 0), width: 120, height: 100);

    canvas.drawOval(rectOval, _paint);

    canvas.save();
    canvas.translate(180, 0);
    canvas.drawArc(rectOval, 0, pi / 2 * 3, true, _paint);
    canvas.restore();
  }

  void _drawArcDetail(Canvas canvas) {
    _paint
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.save();
    canvas.translate(-140, 0);

    Rect circleRect =
        Rect.fromCenter(center: Offset(0, 0), width: 80, height: 80);

    canvas.drawArc(circleRect, 0, pi / 2 * 3, false, _paint);
    canvas.restore();

    canvas.drawArc(circleRect, 0, pi / 2 * 3, true, _paint);

    canvas.save();
    canvas.translate(140, 0);
    _paint..style = PaintingStyle.fill;
    //画“吃豆豆”
    var a = pi / 8;
    canvas.drawArc(circleRect, a, 2 * pi - a.abs() * 2, true, _paint);

    canvas.drawCircle(Offset(30, 0), 8, _paint);
    canvas.drawCircle(Offset(50, 0), 8, _paint);
    canvas.restore();

  }
}
