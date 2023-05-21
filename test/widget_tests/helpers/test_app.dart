import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ScreenUtilInit testAppForWidgetTesting(Widget child) =>
    ScreenUtilInit(builder: (_,__) => MaterialApp(home: child));
