import 'dart:ui';

import 'package:flutter/material.dart';

///网格坐标系
@immutable
class Coordinate {
  final double step;
  final double strokeWidth;
  final Color axisColor;
  final Color gridColor;

  final Paint _gridPaint = new Paint();

  Coordinate(
      {this.step = 20,
      this.strokeWidth = 0.5,
      this.axisColor = Colors.blue,
      this.gridColor = Colors.grey});

  ///绘制坐标
  void paint(Canvas canvas, Size size, {bool withAxis = true}) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    //绘制网格
    _drawGrid(canvas, size);
    //是否需要坐标系
    if (withAxis) {
      _drawAxis(canvas, size);
    }
    canvas.restore();
  }

  ///绘制网格
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

  ///右下角网格
  void _drawBottomRight(Canvas canvas, Size size) {
    _gridPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = gridColor;

    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPaint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  ///坐标系
  void _drawAxis(Canvas canvas, Size size) {
    final Paint _paint = new Paint();
    _paint
      ..color = axisColor
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
