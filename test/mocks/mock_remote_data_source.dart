import 'package:receipe_task/data/data_sources/remote_data_sources.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';

import '../mock_constants/mock_constants.dart';


class MockRemoteDataSource implements RemoteDataSource {
  @override
  Future<List<Food>> fetchFoodList() async {
    return MOCK_FOOD_DETAILS;
  }

  @override
  Future<List<Category>> getCategoryList() async {
    return MOCK_CATEGORY_DETAILS;
  }

  @override
  Future<List<Cuisine>> getCuisineList() async {
    return MOCK_CUISINE_DETAILS;
  }
}
