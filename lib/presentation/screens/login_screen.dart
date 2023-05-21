import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/globals/globals.dart';
import 'package:receipe_task/presentation/providers/login_provider.dart';
import 'package:receipe_task/presentation/widgets/custom_button.dart';
import 'package:receipe_task/presentation/widgets/custom_text_field.dart';
import 'package:receipe_task/utils/colors/app_colors.dart';
import 'package:receipe_task/utils/extensions/extensions.dart';
import 'package:receipe_task/utils/loader/show_loader.dart';
import 'package:receipe_task/utils/routes.dart';

class RecipelyLoginScreen extends StatelessWidget {
  const RecipelyLoginScreen({Key? key}) : super(key: key);

  LoginProvider get loginProvider => sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: loginProvider, child: const RecipelyLoginScreenContent());
  }
}

class RecipelyLoginScreenContent extends StatefulWidget {
  const RecipelyLoginScreenContent({Key? key}) : super(key: key);

  @override
  State<RecipelyLoginScreenContent> createState() => _RecipelyLoginScreenContentState();
}

class _RecipelyLoginScreenContentState extends State<RecipelyLoginScreenContent> {
  late ShowLoader showLoader;

  @override
  void initState() {
    super.initState();
    showLoader = ShowLoader(context);
    context.read<LoginProvider>().toggleShowLoader = () => showLoader.toggle();
    context.read<LoginProvider>().onError = (value) => context.show(message: value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
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
                  'Login',
                  style: TextStyle(color: AppColors.headerTextColor, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: const Column(
                children: [LoginScreenFirstHalf(), LoginScreenSecondHalf()],
              )),
        ),
      ),
    );
  }
}

class LoginScreenFirstHalf extends StatefulWidget {
  const LoginScreenFirstHalf({Key? key}) : super(key: key);

  @override
  State<LoginScreenFirstHalf> createState() => _LoginScreenFirstHalfState();
}

class _LoginScreenFirstHalfState extends State<LoginScreenFirstHalf> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    return Expanded(
      flex: 6,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                'Email Address',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 80.h,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: CustomTextField(
                      key: const ValueKey('email_text_field'),
                      errorText: provider.emailErrorText,
                      controller: emailController,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 20.h,
                      ),
                      labelText: 'Enter Email Address',
                      onChanged: (val) {
                        context.read<LoginProvider>().validateEmailField(val);
                      },
                    ),
                  ),
                  provider.emailErrorText != null
                      ? Text(
                          '${provider.emailErrorText}',
                          style: TextStyle(color: Colors.red, fontSize: 11.sp),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                'Password',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 100.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 80.h,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: CustomTextField(
                        key: const ValueKey('password_text_field'),
                        errorText: provider.passErrorText,
                        controller: passwordController,
                        obscureText: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 20.h,
                        ),
                        labelText: 'Enter Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye_sharp,
                            color: AppColors.lightGreyColor,
                            size: 20.h,
                          ),
                          onPressed: () {},
                        ),
                        onChanged: (val) {
                          context.read<LoginProvider>().validatePasswordField(val);
                        },
                      )),
                  provider.passErrorText != null
                      ? Text(
                          '${provider.passErrorText}',
                          style: TextStyle(color: Colors.red, fontSize: 11.sp),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: CustomButton(
                buttonColor: AppColors.loginButtonColor,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                text: 'Login',
                onPressed: () async {
                  if (context.read<LoginProvider>().emailErrorText != null || context.read<LoginProvider>().passErrorText != null) {
                    return;
                  }

                  final params = LoginWithFirebaseParams(email: emailController.text.trim(), password: passwordController.text.trim());
                  final loggedInWithEmail = await context.read<LoginProvider>().pressLoginButton(params);
                  if (loggedInWithEmail) {
                    moveToNextScreen();
                  }
                },
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                alignment: Alignment.center,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.blackColor, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void moveToNextScreen() {
    Navigator.of(context).pushNamed(mainRoute);
  }
}

class LoginScreenSecondHalf extends StatelessWidget {
  const LoginScreenSecondHalf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              alignment: Alignment.center,
              child: Text(
                'or continue with?',
                style: TextStyle(fontSize: 14.sp, color: AppColors.lightGreyColor, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: CustomSocialNetworkButton(
                buttonColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                socialNetworkIcon: Icon(
                  FontAwesomeIcons.google,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 20.h,
                ),
                text: 'Login with Google',
                onPressed: () {},
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: CustomSocialNetworkButton(
                buttonColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                socialNetworkIcon: Icon(
                  FontAwesomeIcons.facebook,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 20.h,
                ),
                text: 'Login with Facebook',
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 15.h,
            )
          ],
        ));
  }
}
