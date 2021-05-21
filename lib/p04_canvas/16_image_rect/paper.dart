import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_flutter/widget/Coordinate.dart';

///图片 .9 域绘制
class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  late ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_image),
      ),
    );
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/right_chat.png');
    setState(() {});
  }

  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData byteData = await rootBundle.load(path);
    var bytes = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return decodeImageFromList(bytes);
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = new Coordinate();

  final ui.Image image;

  late Paint _paint;
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawImageNine(canvas);
  }

  ///shouldRepaint 方法决定是否重新调用 paint 方法，这里当新旧 image 不同时允许重绘
  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;

  void _drawImageNine(ui.Canvas canvas) {
    if (image != null) {

      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
              width: image.width-20.0, height: 2.0),
          Rect.fromCenter(center: Offset(0, 0), width:200, height: 120),
          _paint);

      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
              width: image.width-20.0, height: 2.0),
          Rect.fromCenter(center: Offset(0, 0,), width:100, height: 50).translate(200, 0),
          _paint);

      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
              width: image.width-20.0, height: 2.0),
          Rect.fromCenter(center: Offset(0, 0,), width:80, height: 250).translate(-200, 0),
          _paint);

    }
  }
}
