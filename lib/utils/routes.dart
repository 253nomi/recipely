import 'package:flutter/material.dart';
import 'package:receipe_task/presentation/screens/login_screen.dart';
import 'package:receipe_task/presentation/screens/main_screen.dart';
import 'package:receipe_task/presentation/screens/splash_screen.dart';


const initialRoute = '/splashRoute';
const signInRoute = '/signInRoute';
const mainRoute = '/mainRoute';


MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case initialRoute:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const RecipelySplashScreen(),
      );

    case signInRoute:
      return MaterialPageRoute(
        builder: (context) => const RecipelyLoginScreen(),
        settings: settings,
      );

    case mainRoute:
      return MaterialPageRoute(
        builder: (context) => const RecipelyMainScreen(),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => Container(),
      );
  }
}
