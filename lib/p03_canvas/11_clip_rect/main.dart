import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_flutter/p03_canvas/11_clip_rect/paper.dart';

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
