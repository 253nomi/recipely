import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/utils/colors/app_colors.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/food.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10.r),
                shape: BoxShape.rectangle,
              ),
              child: Icon(Icons.person, color: Theme.of(context).primaryColor),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      food.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      food.chef,
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.lightGreyColor),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
              decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: BorderRadius.circular(10.r)),
              child: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).scaffoldBackgroundColor,
                size: 20.h,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
