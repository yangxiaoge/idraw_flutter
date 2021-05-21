import 'dart:math';

import 'package:flutter/material.dart';

///运行： flutter run --target=lib/p02_paint/level2/main.dart
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
  @override
  void paint(Canvas canvas, Size size) {
    //线帽类型strokeCap
    //drawStrokeCap(canvas);
    //线接类型strokeJoin
    //drawStrokeJoin(canvas);

    //五角星-小测试
    drawStar(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void drawStrokeCap(Canvas canvas) {
    //详细认识画笔 -- Level2
    final Paint mPaint = new Paint();
    mPaint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;

    //线帽类型strokeCap
    canvas.drawLine(
      Offset(50, 50),
      Offset(50, 150),
      //不出头
      mPaint..strokeCap = StrokeCap.butt,
    );
    canvas.drawLine(
      Offset(50 + 50, 50),
      Offset(50 + 50, 150),
      //圆头
      mPaint..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(50 + 50 + 50, 50),
      Offset(50 + 50 + 50, 150),
      //方头
      mPaint..strokeCap = StrokeCap.square,
    );
  }

  void drawStrokeJoin(Canvas canvas) {
    final Paint mPaint = new Paint();
    mPaint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    final Path mPath = new Path();

    mPath.moveTo(50, 50);
    mPath.lineTo(50, 150);
    mPath.lineTo(50 + 50, 100);
    mPath.lineTo(50 + 50, 150 + 50);
    canvas.drawPath(
      mPath,
      //斜角
      mPaint..strokeJoin = StrokeJoin.bevel,
    );

    mPath.reset();
    mPath.moveTo(50 + 50 + 50, 50);
    mPath.lineTo(50 + 50 + 50, 150);
    mPath.relativeLineTo(100, -50);
    mPath.relativeLineTo(0, 100);
    canvas.drawPath(
      mPath,
      //锐角
      mPaint..strokeJoin = StrokeJoin.miter,
    );

    mPath.reset();
    mPath.moveTo(300, 50);
    mPath.lineTo(300, 150);
    mPath.relativeLineTo(100, -50);
    mPath.relativeLineTo(0, 100);
    canvas.drawPath(
      mPath,
      //圆角
      mPaint..strokeJoin = StrokeJoin.round,
    );
  }

  void drawStar(Canvas canvas, Size size) {
    final Paint mPaint = new Paint();
    mPaint
      ..style = PaintingStyle.fill
      ..color = Colors.red
      ..isAntiAlias = true;
    final Path mPath = new Path();

    //圆形移动到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);

    //将圆5等分，得到5个坐标
    var points = getCirclePoints(size.height / 3, 0, 0, 5);
    print(
        "size.width = ${size.width} size.height = ${size.height} \n points[0] = ${points}");

    mPath.moveTo(points[0].dx, points[0].dy);
    mPath.lineTo(points[2].dx, points[2].dy);
    mPath.lineTo(points[4].dx, points[4].dy);
    mPath.lineTo(points[1].dx, points[1].dy);
    mPath.lineTo(points[3].dx, points[3].dy);
    mPath.lineTo(points[0].dx, points[0].dy);

    canvas.drawPath(mPath, mPaint);
  }

  List<Offset> getCirclePoints(double R, double cx, double xy, int count) {
    final List<Offset> points = [];
    var radians = pi / 180 * (360 / count);
    for (int i = 0; i < count; i++) {
      var x = cx + R * sin(radians * i);
      var y = xy - R * cos(radians * i);
      points.add(Offset(x, y));
    }
    return points;
  }
}
