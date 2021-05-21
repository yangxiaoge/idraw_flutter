import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idraw_flutter/widget/grid_paper.dart';

///绘制画笔drawPaint: https://juejin.cn/book/6844733827265331214/section/6844733827307274247
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
    //画网格
    MyGridPaper.drawGrid(canvas, size);

    final Paint _paint = new Paint();
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
        Offset(0, 0), Offset(size.width / 6, 0), colors, pos, TileMode.clamp);
    _paint.blendMode = BlendMode.lighten;
    //画布绘制画笔drawPaint
    canvas.drawPaint(_paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
