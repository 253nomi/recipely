import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipe_task/utils/colors/app_colors.dart';
import 'package:receipe_task/utils/routes.dart';

class RecipelySplashScreen extends StatefulWidget {
  const RecipelySplashScreen({Key? key}) : super(key: key);

  @override
  State<RecipelySplashScreen> createState() => _RecipelySplashScreenState();
}

class _RecipelySplashScreenState extends State<RecipelySplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => Navigator.of(context).pushNamed(signInRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashScreenColor,
      body: Center(
        child: Text(
          'Recipely',
          style: TextStyle(fontSize: 32.sp, color: AppColors.splashTextColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
