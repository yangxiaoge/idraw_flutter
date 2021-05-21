import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_flutter/p03_canvas/04_point_line/paper.dart';

///运行： flutter run --target=lib/p03_canvas/04_point_line/main.dart
void main() {
  //确定初始化
  WidgetsFlutterBinding.ensureInitialized();
  //横屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}
