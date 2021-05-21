import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idraw_flutter/widget/Coordinate.dart';

///路径裁剪
class Paper extends StatelessWidget {
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
  final Coordinate coordinate = new Coordinate();
  late final Paint _paint;
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  PaperPainter() {
    _paint = new Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //画网格
    coordinate.paint(canvas, size);
    //圆心移动到中心
    canvas.translate(size.width / 2, size.height / 2);

    final Path _path =new Path();
    _path.lineTo(50, 50);
    _path.lineTo(-50, 50);
    _path.close();
    //路径裁剪
    canvas.clipPath(_path);

    //以下绘制的颜色，只能在上面裁剪的区域画出来
    canvas.drawColor(Colors.red, BlendMode.darken);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
