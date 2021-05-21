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
  @override
  void paint(Canvas canvas, Size size) {
    //画网格
    MyGridPaper.drawGrid(canvas, size);
    //画布绘制颜色 drawColor
    canvas.drawColor(Colors.red, BlendMode.lighten);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
