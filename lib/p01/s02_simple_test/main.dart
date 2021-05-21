import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_flutter/p01/s02_simple_test/paper.dart';

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
