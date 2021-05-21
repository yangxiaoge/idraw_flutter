import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_flutter/p02_paint/level2/paper.dart';

///运行： flutter run --target=lib/p02_paint/level2/main.dart
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
