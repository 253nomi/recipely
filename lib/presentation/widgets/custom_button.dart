import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final VoidCallback? onPressed;
  final ValueNotifier<bool>? loadingNotifier;
  final ValueNotifier<bool> _isEnabledNotifier;
  final EdgeInsets _padding;

  CustomButton({Key? key, required this.text, required this.onPressed, this.loadingNotifier, ValueNotifier<bool>? isEnabledNotifier, EdgeInsets? padding, required this.buttonColor})
      : _isEnabledNotifier = isEnabledNotifier ?? ValueNotifier(true),
        _padding = padding ?? EdgeInsets.zero,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loadingNotifier == null) {
      return Container(
        height: 80.h,
        width: double.infinity,
        padding: _padding,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 14.sp),
          ),
        ),
      );
    }

    return Container(
      padding: _padding,
      child: ValueListenableBuilder<bool>(
          valueListenable: _isEnabledNotifier,
          builder: (context, isEnabled, child) {
            return ValueListenableBuilder<bool>(
                valueListenable: loadingNotifier!,
                builder: (context, isLoading, child) {
                  return ElevatedButton(
                    onPressed: shouldButtonBeEnabled(isEnabled, isLoading) ? onPressed : () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    child: (isLoading)
                        ? CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).scaffoldBackgroundColor))
                        : Text(
                            text,
                          ),
                  );
                });
          }),
    );
  }

  bool shouldButtonBeEnabled(bool isEnabled, bool isLoading) => isEnabled && !isLoading;
}

class CustomSocialNetworkButton extends StatelessWidget {
  final Icon socialNetworkIcon;
  final Color buttonColor;
  final String text;
  final VoidCallback? onPressed;
  final ValueNotifier<bool>? loadingNotifier;
  final EdgeInsets _padding;

  const CustomSocialNetworkButton({Key? key, required this.text, required this.onPressed, this.loadingNotifier, EdgeInsets? padding, required this.buttonColor, required this.socialNetworkIcon})
      : _padding = padding ?? EdgeInsets.zero,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      padding: _padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container(padding: EdgeInsets.only(left: 70.w), child: socialNetworkIcon)),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  text,
                  style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
