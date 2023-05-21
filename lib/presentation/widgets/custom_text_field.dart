import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipe_task/utils/colors/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final IconButton? suffixIcon;
  final String labelText;
  final Icon prefixIcon;

  const CustomTextField(
      {Key? key, required this.labelText, required this.prefixIcon, this.suffixIcon, required this.onChanged, this.validator, this.obscureText, required this.controller, this.errorText})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          contentPadding: EdgeInsets.only(bottom: 4.h),
          labelStyle: TextStyle(color: AppColors.lightGreyColor, fontSize: 14.sp),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(width: 0.5, color: Theme.of(context).colorScheme.error)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(width: 0.5, color: AppColors.lightGreyColor)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r), borderSide: BorderSide(width: 1.0, color: AppColors.lightGreyColor))),
      onChanged: (text) {
        widget.onChanged?.call(text);
        setState(() {});
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
    );
  }
}
