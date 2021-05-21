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
    mPaint
      ..color = Colors.black
      ..isAntiAlias = true;

    //画圆
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10, mPaint);

    //画线
    canvas.drawLine(
        Offset(0, 0),
        Offset(100, 100),
        mPaint
          ..color = Colors.blue
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke);

    final Path mPath = new Path();
    mPath.moveTo(100, 100);
    mPath.lineTo(200, 0);
    //画路径
    canvas.drawPath(mPath, mPaint..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
