import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idraw_flutter/widget/Coordinate.dart';

///矩形裁剪
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

    Rect rect = Rect.fromCenter(center: Offset.zero, width: 360, height: 240);
    //矩形裁剪(ClipOp.intersect 裁内部(默认) ClipOp.difference 裁外部)
    canvas.clipRect(rect, clipOp: ui.ClipOp.intersect, doAntiAlias: true);

    //以下绘制的渐变色Paint，只能在上面裁剪的区域画出来
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
    _paint.shader = ui.Gradient.linear(
        rect.centerLeft, rect.centerRight, colors, pos, TileMode.clamp);
    _paint.blendMode = BlendMode.src;
    canvas.drawPaint(_paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
