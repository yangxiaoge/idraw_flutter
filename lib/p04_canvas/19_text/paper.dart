import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idraw_flutter/widget/Coordinate.dart';

///drawParagraph绘制文字
///flutter run -d windows --target=lib/p04_canvas/19_text/main.dart
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
  final Coordinate coordinate = new Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    _drawParagraph(canvas);
    _drawTextPaint(canvas);
    _drawTextPaintWithPaint(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawParagraph(Canvas canvas) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 40,
        textDirection: ui.TextDirection.ltr,
        maxLines: 1));
    builder.pushStyle(ui.TextStyle(
        color: Colors.black, textBaseline: TextBaseline.alphabetic));
    builder.addText("Hello Bruce");
    var paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: 300));
    //画文字
    canvas.drawParagraph(paragraph, Offset.zero);
    //画矩形
    canvas.drawRect(Rect.fromLTRB(0, 0, paragraph.width, paragraph.height),
        new Paint()..color = Colors.blue.withAlpha(30));
  }

  void _drawTextPaint(ui.Canvas canvas) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: "Hello Bruce",
            style: TextStyle(fontSize: 40, color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr);
    // 进行布局
    textPainter.layout();
    // 尺寸必须在布局后获取
    Size size = textPainter.size;
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2 - 100));
    canvas.drawRect(
        Rect.fromLTWH(
            -size.width / 2, -size.height / 2 - 100, size.width, size.height),
        new Paint()..color = Colors.blue.withAlpha(30));
  }

  void _drawTextPaintWithPaint(ui.Canvas canvas) {
    final Paint textPaint = new Paint();
    textPaint
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var textPainter = TextPainter(
        text: TextSpan(
            text: "Hello Bruce 杨小哥", style: TextStyle(foreground: textPaint,fontSize: 40)),
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr);

    textPainter.layout(maxWidth:210);
    Size size = textPainter.size;

    textPainter.paint(canvas, Offset(100, 100));
    canvas.drawRect(Rect.fromLTWH(100, 100, size.width, size.height), new Paint()..color = Colors.blue.withAlpha(30));
  }
}
