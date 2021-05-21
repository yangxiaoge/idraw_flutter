import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: RichTextWithWidget(),
        // child: CustomPaint(painter: PaperPainter()),
      ),
    );
  }
}

class RichTextWithWidget extends StatelessWidget {
  const RichTextWithWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
          ),
          children: <InlineSpan>[
            TextSpan(text: "Flutter 绘制指南 - 妙笔生花\n",  style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),),
            TextSpan(text: "https://juejin.cn/book/6844733827265331214",  style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              decoration: TextDecoration.underline
            ),)
          ]),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.red;
    canvas.drawCircle(Offset(100, 100), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
