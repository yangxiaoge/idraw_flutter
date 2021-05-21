import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idraw_flutter/widget/Coordinate.dart';
import 'package:idraw_flutter/widget/grid_paper.dart';

///绘制阴影drawShadow
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
  @override
  void paint(Canvas canvas, Size size) {
    //画网格
    //MyGridPaper.drawGrid(canvas, size);
    coordinate.paint(canvas, size);
    //圆心移动到中心
    canvas.translate(size.width / 2, size.height / 2);

    final Path _path =new Path();
    _path.lineTo(50, 50);
    _path.lineTo(-50, 50);
    _path.close();
    //绘制阴影drawShadow(第四个参数：内部是否显示 transparentOccluder)
    canvas.drawShadow(_path, Colors.blue, 2, true);

    canvas.save();
    canvas.translate(120, 0);
    //绘制阴影drawShadow(第四个参数：内部是否显示 transparentOccluder)
    canvas.drawShadow(_path, Colors.blue, 2, false);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
