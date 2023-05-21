import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/globals/globals.dart';
import 'package:receipe_task/utils/routes.dart';

extension SetScreenSize on WidgetTester {
  Future<void> setScreenSize({double width = 423, double height = 1024, double pixelDensity = 1}) async {
    final size = Size(width, height);
    await binding.setSurfaceSize(size);
    view.physicalSize = size;
    view.devicePixelRatio = pixelDensity;
  }

  Future testAppForWidgetTesting(Widget child, {Duration duration = Duration.zero}) async {
    return pumpWidget(Builder(builder: (context) {
      return ScreenUtilInit(
          designSize: const Size(423, 1024),
          builder: (context, _) {
            return MaterialApp(
              onGenerateRoute: onGenerateRoute,
              navigatorKey: navigatorKeyGlobal,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: Builder(builder: (context) {
                ScreenUtil.init(context);
                return child;
              }),
            );
          });
    }), duration);
  }
}
