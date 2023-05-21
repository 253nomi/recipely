import 'package:receipe_task/data/data_sources/remote_data_sources.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/utils/constants/constants.dart';

class MockRemoteDataSourceError implements RemoteDataSource {
  @override
  Future<List<Food>> fetchFoodList() async {
    throw SOMETHING_WENT_WRONG;
  }

  @override
  Future<List<Category>> getCategoryList() async {
    throw SOMETHING_WENT_WRONG;
  }

  @override
  Future<List<Cuisine>> getCuisineList() async {
    throw SOMETHING_WENT_WRONG;
  }
}
