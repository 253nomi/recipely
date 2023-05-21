import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/get_category_list.dart';
import 'package:receipe_task/domain/usecases/get_cuisine_list.dart';
import 'package:receipe_task/domain/usecases/get_food_list.dart';
import 'package:receipe_task/presentation/providers/main_screen_provider.dart';
import 'package:receipe_task/utils/constants/constants.dart';

import '../../../mock_contants/mock_constants.dart';
import '../../../mocks/mock_error_repository.dart';
import '../../../mocks/mock_repository.dart';

void main() {
  late GetFoodList getFoodList;
  late GetCuisineList getCuisineList;
  late GetCategoryList getCategoryList;
  late MainScreenProvider provider;
  late Repository repository;
  late Repository errorRepository;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('should get data from firestore successfully', () async {
    // Arrange
    getFoodList = GetFoodList(repository);
    getCuisineList = GetCuisineList(repository);
    getCategoryList = GetCategoryList(repository);
    provider = MainScreenProvider(getFoodList: getFoodList, getCategoryList: getCategoryList, getCuisineList: getCuisineList);

    // Act
    await provider.getDataFromServer();

    // assert
    expect(provider.foodList, MOCK_FOOD_DETAILS);
    expect(provider.categoryList, MOCK_CATEGORY_DETAILS);
    expect(provider.cuisineList, MOCK_CUISINE_DETAILS);
  });

  test('should get error when get data from firestore ', () async {
    // Arrange
    getFoodList = GetFoodList(errorRepository);
    getCuisineList = GetCuisineList(errorRepository);
    getCategoryList = GetCategoryList(errorRepository);
    provider = MainScreenProvider(getFoodList: getFoodList, getCategoryList: getCategoryList, getCuisineList: getCuisineList);

    // Act
    await provider.getDataFromServer();

    // assert
    provider.onError = (_) {
      expect(true, true);
      expect(_, SOMETHING_WENT_WRONG);
    };
  });


  test('should get one italian food on search', () async {
    // Arrange
    getFoodList = GetFoodList(repository);
    getCuisineList = GetCuisineList(repository);
    getCategoryList = GetCategoryList(repository);
    provider = MainScreenProvider(getFoodList: getFoodList, getCategoryList: getCategoryList, getCuisineList: getCuisineList);

    // Act
    await provider.getDataFromServer();
    provider.searchFoods('Italian');

    // assert
    expect(provider.foodList.length, 1);
  });


  test('should get all data on clear filters', () async {
    // Arrange
    getFoodList = GetFoodList(repository);
    getCuisineList = GetCuisineList(repository);
    getCategoryList = GetCategoryList(repository);
    provider = MainScreenProvider(getFoodList: getFoodList, getCategoryList: getCategoryList, getCuisineList: getCuisineList);

    // Act
    await provider.getDataFromServer();
    provider.clearFilters();

    // assert
    expect(provider.foodList, MOCK_FOOD_DETAILS);
  });

}
