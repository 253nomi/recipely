import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
    required this.tablet,
  }) : super(key: key);
  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 970 &&
      MediaQuery.of(context).size.width > 650;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 970;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 970) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
