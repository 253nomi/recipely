import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowLoader {
  BuildContext buildContext;
  bool isShowing = false;

  ShowLoader(this.buildContext);

  void toggle() {
    if (isShowing) {
      isShowing = false;
      Navigator.of(buildContext, rootNavigator: true).pop();
      return;
    }

    var alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(buildContext).primaryColor),
          ),
          Container(margin: EdgeInsets.only(left: 12.w), child: const Text('loading...')),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: buildContext,
        useRootNavigator: true,
        builder: (_) {
          return alert;
        });
    isShowing = true;
  }
}
