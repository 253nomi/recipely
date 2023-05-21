import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/get_category_list.dart';
import 'package:receipe_task/domain/usecases/get_cuisine_list.dart';
import 'package:receipe_task/domain/usecases/get_food_list.dart';
import 'package:receipe_task/presentation/providers/main_screen_provider.dart';
import 'package:receipe_task/presentation/screens/main_screen.dart';

import '../../mocks/mock_repository.dart';
import '../helpers/extensions.dart';


void main(){
  late GetFoodList getFoodList;
  late GetCuisineList getCuisineList;
  late GetCategoryList getCategoryList;
  late MainScreenProvider provider;
  late Repository repository;

  setUp(() {
    repository = MockRepository();
    getFoodList = GetFoodList(repository);
    getCuisineList = GetCuisineList(repository);
    getCategoryList = GetCategoryList(repository);
    provider = MainScreenProvider(getFoodList: getFoodList, getCategoryList: getCategoryList, getCuisineList: getCuisineList);
    GetIt.I.registerSingleton(provider);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('should show main screen', (WidgetTester tester) async{

    final searchTextFinder = find.text('Search');
    final searchTextFieldFinder = find.byKey(const ValueKey('search_text_field'));
    final iconFinder = find.byType(Icon);

    await tester.setScreenSize();
    await tester.testAppForWidgetTesting(const RecipelyMainScreen());

    expect(searchTextFinder, findsWidgets);
    expect(searchTextFieldFinder, findsOneWidget);
    expect(iconFinder, findsWidgets);
  });


  testWidgets('should show main screen content', (WidgetTester tester) async{

    final searchTextFinder = find.text('Search');
    final searchTextFieldFinder = find.byKey(const ValueKey('search_text_field'));
    final iconFinder = find.byType(Icon);

    await tester.setScreenSize();
    await tester.testAppForWidgetTesting(ChangeNotifierProvider.value(
        value: provider,
        child: const RecipelyMainScreenContent()));

    expect(searchTextFinder, findsWidgets);
    expect(searchTextFieldFinder, findsOneWidget);
    expect(iconFinder, findsWidgets);
  });
}