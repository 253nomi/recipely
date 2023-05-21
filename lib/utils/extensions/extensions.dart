import 'package:flutter/material.dart';

extension ScaffoldHelper on BuildContext? {
  void show({required String message, SnackBarBehavior? snackBarBehavior = SnackBarBehavior.fixed}) {
    if (this == null) {
      return;
    }

    ScaffoldMessenger.maybeOf(this!)
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: snackBarBehavior,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        duration: const Duration(seconds: 2),
      ));
  }
}
