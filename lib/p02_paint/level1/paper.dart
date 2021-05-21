import 'package:flutter/material.dart';

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
    final Paint mPaint = new Paint();
    //画左圆
    canvas.drawCircle(
        Offset(size.width / 4, size.height / 2),
        size.width / 5,
        mPaint
          ..color = Colors.blue
          ..strokeWidth = 60 //画笔类型 style 和线宽 strokeWidth
          ..style = PaintingStyle.stroke);
    //画右圆
    canvas.drawCircle(
        Offset(size.width * 3 / 4, size.height / 2),
        size.width / 4,
        mPaint
          ..color = Colors.red
          ..isAntiAlias = true
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
