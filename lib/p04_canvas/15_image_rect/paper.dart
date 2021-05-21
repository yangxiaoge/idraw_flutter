import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_flutter/widget/Coordinate.dart';

///flutter run -d windows --target=lib/p04_canvas/15_image_rect/main.dart
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
    _image = await loadImageFromAssets('assets/images/wy_300x200.jpg');
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
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawImageRect(canvas);
  }

  ///shouldRepaint 方法决定是否重新调用 paint 方法，这里当新旧 image 不同时允许重绘
  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;

  void _drawImageRect(ui.Canvas canvas) {
    if (image != null) {
      canvas.drawImage(
          image, Offset(-image.width / 2, -image.height / 2), _paint);

      canvas.drawImageRect(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height / 2),
              width: 60,
              height: 60),
          ui.Rect.fromLTRB(0, 0, 100, 100).translate(160, 0),
          _paint);

      canvas.drawImageRect(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height / 2 - 60),
              width: 100,
              height: 100),
          Rect.fromLTRB(0, 0, 60, 60).translate(-260, -100),
          _paint);

      canvas.drawImageRect(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2 + 60, image.height / 2),
              width: 60,
              height: 60),
          Rect.fromLTRB(0, 0, 100, 100).translate(-260, 50),
          _paint);
    }
  }
}
