import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:receipe_task/globals/globals.dart';
import 'package:receipe_task/presentation/providers/main_screen_provider.dart';
import 'package:receipe_task/presentation/widgets/custom_button.dart';
import 'package:receipe_task/utils/colors/app_colors.dart';

class FilterBottomSheet {
  final BuildContext context;

  FilterBottomSheet({required this.context});

  Future<void> show() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return const FilterBottomSheetScreen();
      },
    );
  }
}

class FilterBottomSheetScreen extends StatelessWidget {
  MainScreenProvider get mainScreenProvider => sl();

  const FilterBottomSheetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: mainScreenProvider, child: const BottomSheetContent());
  }
}

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({Key? key}) : super(key: key);

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    final mainScreenProvider = context.watch<MainScreenProvider>();
    return Container(
      padding: EdgeInsets.only(
        left: 25.0.w,
        top: 25.0.w,
        bottom: 14.0.w,
        right: 25.0.w,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                'Search',
                style: TextStyle(color: AppColors.headerTextColor, fontWeight: FontWeight.bold, fontSize: 24.sp),
              ),
            ),
            Text(
              'Category',
              style: TextStyle(color: AppColors.headerTextColor, fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 3 / 1.2, crossAxisSpacing: 10.w, crossAxisCount: 3),
                  itemCount: mainScreenProvider.categoryList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      child: BottomSheetOption(
                        text: mainScreenProvider.categoryList[index].name,
                        selected: mainScreenProvider.selectedCategoryList.contains(mainScreenProvider.categoryList[index]),
                      ),
                      onTap: () {
                        context.read<MainScreenProvider>().addOrRemoveSelectedCategory(mainScreenProvider.categoryList[index]);
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Cuisine',
              style: TextStyle(color: AppColors.headerTextColor, fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 3 / 1.2, crossAxisSpacing: 10.w, mainAxisSpacing: 20.h, crossAxisCount: 3),
                  itemCount: mainScreenProvider.cuisineList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      child: BottomSheetOption(
                        text: mainScreenProvider.cuisineList[index].name,
                        selected: mainScreenProvider.selectedCuisineList.contains(mainScreenProvider.cuisineList[index]),
                      ),
                      onTap: () {
                        context.read<MainScreenProvider>().addOrRemoveSelectedCuisine(mainScreenProvider.cuisineList[index]);
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
                text: 'Apply Filter',
                onPressed: () {
                  context.read<MainScreenProvider>().applyFilters();
                  Navigator.of(context).pop();
                },
                buttonColor: AppColors.splashScreenColor),
            SizedBox(
              height: 20.h,
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Text(
                  'Clear Filter',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.blackColor, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  context.read<MainScreenProvider>().clearFilters();
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetOption extends StatelessWidget {
  final String text;
  final bool selected;

  const BottomSheetOption({Key? key, required this.selected, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: selected ? AppColors.splashScreenColor : Colors.grey),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: selected ? Theme.of(context).scaffoldBackgroundColor : AppColors.blackColor),
      ),
    );
  }
}
