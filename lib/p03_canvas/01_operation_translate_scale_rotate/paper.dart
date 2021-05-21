import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  late Paint _gridPint; //网格画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色

  PaperPainter() {
    _gridPint = new Paint();
    _gridPint
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 画布起点移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);

    //画右下角网格
    _drawBottomRight(canvas, size);

    canvas.save();
    //沿x轴镜像
    canvas.scale(1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    //沿着y轴镜像
    canvas.scale(-1, 1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    //沿圆心镜像
    canvas.scale(-1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    //画中心圆
    _drawCenterCircle(canvas, size);

    //画围绕圆的太阳光
    _drawDot(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();

    //画横线
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      //垂直step移动纸
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    //画竖线
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      //水平step移动纸
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _drawCenterCircle(Canvas canvas, Size size) {
    final Paint mPaint = new Paint();
    mPaint
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    //画圆
    canvas.drawCircle(Offset(0, 0), 50, mPaint);
    canvas.drawLine(
      Offset(20, 20),
      Offset(50, 50),
      mPaint
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawDot(Canvas canvas, Size size) {
    final Paint mPaint = new Paint();
    mPaint
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    final count = 12;

    canvas.save();
    for (int i = 0; i < count; i++) {
      canvas.drawLine(Offset(0, -80), Offset(0, -100), mPaint);
      //顺时针旋转弧度（360° = 2pi 弧度）
      canvas.rotate(2 * pi / count);
    }
    canvas.restore();
  }
}
