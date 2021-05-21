import 'dart:ui';

import 'package:flutter/material.dart';

class MyGridPaper {
  ///绘制网格+坐标系
  static void drawGrid(Canvas canvas, Size size, {bool withAxis = true}) {
    canvas.translate(size.width / 2, size.height / 2);

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

    //是否需要坐标系
    if (withAxis) {
      _drawAxis(canvas, size);
    }

  }

  ///右下角网格
  static void _drawBottomRight(Canvas canvas, Size size) {
    final Paint _gridPint = new Paint();
    _gridPint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = Colors.grey;
    final double step = 20;

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

  ///坐标系
  static void _drawAxis(Canvas canvas, Size size) {
    final Paint _paint = new Paint();
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
}
