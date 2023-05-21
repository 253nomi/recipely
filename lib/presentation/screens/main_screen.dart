import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:receipe_task/globals/globals.dart';
import 'package:receipe_task/presentation/providers/main_screen_provider.dart';
import 'package:receipe_task/presentation/widgets/custom_text_field.dart';
import 'package:receipe_task/presentation/widgets/filter_bottom_sheet.dart';
import 'package:receipe_task/presentation/widgets/food_card.dart';
import 'package:receipe_task/utils/colors/app_colors.dart';
import 'package:receipe_task/utils/extensions/extensions.dart';
import 'package:receipe_task/utils/loader/show_loader.dart';

class RecipelyMainScreen extends StatelessWidget {
  const RecipelyMainScreen({Key? key}) : super(key: key);

  MainScreenProvider get mainScreenProvider => sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: mainScreenProvider, child: const RecipelyMainScreenContent());
  }
}

class RecipelyMainScreenContent extends StatefulWidget {
  const RecipelyMainScreenContent({Key? key}) : super(key: key);

  @override
  State<RecipelyMainScreenContent> createState() => _RecipelyMainScreenContentState();
}

class _RecipelyMainScreenContentState extends State<RecipelyMainScreenContent> {
  late ShowLoader showLoader;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showLoader = ShowLoader(context);
    context.read<MainScreenProvider>().getDataFromServer();
    context.read<MainScreenProvider>().toggleShowLoader = () => showLoader.toggle();
    context.read<MainScreenProvider>().onError = (value) => context.show(message: value);
    searchController.addListener(() {
      context.read<MainScreenProvider>().searchFoods(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MainScreenProvider>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              size: 25.h,
              color: AppColors.blackColor,
            ),
          ),
          iconTheme: IconThemeData(color: AppColors.blackColor),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 56.h),
              child: Text(
                'Search',
                style: TextStyle(color: AppColors.headerTextColor, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 11,
                    child: Container(
                      height: 80.h,
                      padding: EdgeInsets.only(right: 10.w),
                      child: CustomTextField(
                        key: const ValueKey('search_text_field'),
                          labelText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20.h,
                          ),
                          onChanged: (val) {},
                          controller: searchController),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: ()async{
                          final filterBottomSheet = FilterBottomSheet(context: context);
                          await filterBottomSheet.show();
                        },
                        child: Container(
                          height: 58.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(color: AppColors.splashScreenColor, borderRadius: BorderRadius.circular(10.r)),
                          child: Icon(
                            Icons.menu,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            size: 20.h,
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Visibility(
                visible: provider.foodList.isNotEmpty,
                child: Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      itemCount: provider.foodList.length,
                      itemBuilder: (_, __) {
                        return FoodCard(food: provider.foodList[__]);
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
