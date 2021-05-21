import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_flutter/widget/Coordinate.dart';

///绘制图集:drawAtlas
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
    _image = await loadImageFromAssets('assets/images/shoot.png');
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

  final List<Sprite> allSprites = [];

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    //canvas.translate(size.width / 2, size.height / 2);
    _drawAtlas(canvas);
    // _drawRawAtlas(canvas);
  }

  ///shouldRepaint 方法决定是否重新调用 paint 方法，这里当新旧 image 不同时允许重绘
  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;

  void _drawAtlas(ui.Canvas canvas) {
    if (image != null) {
      //从image中框中一块
      Rect rectSelectFromImage = Rect.fromLTWH(0, 325, 257, 166);

      allSprites.add(Sprite(
          position: rectSelectFromImage,
          offset: Offset(0, 0),
          alpha: 255,
          rotation: 0));

      allSprites.add(Sprite(
          position: rectSelectFromImage,
          offset: Offset(257, 120),
          alpha: 255,
          rotation: 0));

      final List<RSTransform> transforms = allSprites
          .map((sprite) => RSTransform.fromComponents(
              rotation: sprite.rotation,
              scale: 1.0,
              anchorX: sprite.anchor.dx,
              anchorY: sprite.anchor.dy,
              translateX: sprite.offset.dx,
              translateY: sprite.offset.dy))
          .toList();

      final List<Rect> rects =
          allSprites.map((sprite) => sprite.position).toList();

      //绘制一个图片, 图形的变换
      canvas.drawAtlas(image, transforms, rects, null, null, null, _paint);
    }
  }

  void _drawRawAtlas(ui.Canvas canvas) {
    if (image != null) {
      //从image中框中一块
      Rect rectSelectFromImage = Rect.fromLTWH(0, 325, 257, 166);

      allSprites.add(Sprite(
          position: rectSelectFromImage,
          offset: Offset(0, 0),
          alpha: 255,
          rotation: 0));

      allSprites.add(Sprite(
          position: rectSelectFromImage,
          offset: Offset(257, 120),
          alpha: 255,
          rotation: 0));

      Float32List rectList = Float32List(allSprites.length * 4);
      Float32List transformList = Float32List(allSprites.length * 4);

      for (int i = 0; i < allSprites.length; i++) {
        final Sprite sprite = allSprites[i];
        rectList[i * 4 + 0] = sprite.position.left;
        rectList[i * 4 + 1] = sprite.position.top;
        rectList[i * 4 + 2] = sprite.position.right;
        rectList[i * 4 + 3] = sprite.position.bottom;
        final RSTransform transform = RSTransform.fromComponents(
          rotation: sprite.rotation,
          scale: 1.0,
          anchorX: sprite.anchor.dx,
          anchorY: sprite.anchor.dy,
          translateX: sprite.offset.dx,
          translateY: sprite.offset.dy,
        );
        transformList[i * 4 + 0] = transform.scos;
        transformList[i * 4 + 1] = transform.ssin;
        transformList[i * 4 + 2] = transform.tx;
        transformList[i * 4 + 3] = transform.ty;
      }

      //绘制一个图片, 图形的变换
      canvas.drawRawAtlas(image, rectList, transformList, null, null, null, _paint);

    }
  }
}

class Sprite {
  Rect position; // 雪碧图 中 图片矩形区域
  Offset offset; // 移动偏倚
  Offset anchor; // 移动偏倚
  int alpha; // 透明度
  double rotation; // 旋转角度

  Sprite(
      {this.offset = Offset.zero,
      this.anchor = Offset.zero,
      this.alpha = 255,
      required this.rotation,
      required this.position});
}
