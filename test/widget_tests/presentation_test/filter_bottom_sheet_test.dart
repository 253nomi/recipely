import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/get_category_list.dart';
import 'package:receipe_task/domain/usecases/get_cuisine_list.dart';
import 'package:receipe_task/domain/usecases/get_food_list.dart';
import 'package:receipe_task/presentation/providers/main_screen_provider.dart';
import 'package:receipe_task/presentation/widgets/filter_bottom_sheet.dart';
import '../../mock_constants/mock_constants.dart';
import '../../mocks/mock_repository.dart';
import '../helpers/extensions.dart';

void main() {
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

  testWidgets('should show filter bottom sheet', (WidgetTester tester) async {
    provider.cuisineList = MOCK_CUISINE_DETAILS;
    provider.categoryList = MOCK_CATEGORY_DETAILS;

    await tester.setScreenSize();
    await tester.testAppForWidgetTesting(MaterialApp(
      home: Material(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            ),
          ],
          child: Builder(builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  final filterBottomSheet = FilterBottomSheet(context: context);
                  await filterBottomSheet.show();
                },
                child: const Text('Go'),
              ),
            );
          }),
        ),
      ),
    ));

    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Cuisine'), findsOneWidget);
    expect(find.text('Apply Filter'), findsOneWidget);
    expect(find.text('Clear Filter'), findsOneWidget);
  });
}
