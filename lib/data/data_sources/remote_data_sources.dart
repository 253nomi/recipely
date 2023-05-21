import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';

abstract class RemoteDataSource {
  /// This method will return food list from firestore
  /// Output : if operation successful returns [Food] list of food
  /// if unsuccessful the response will be [Failure]
  Future<List<Food>> fetchFoodList();

  /// This method will return category list from firestore
  /// Output : if operation successful returns [Category] list of category
  /// if unsuccessful the response will be [Failure]
  Future<List<Category>> getCategoryList();

  /// This method will return cuisine list from firestore
  /// Output : if operation successful returns [Cuisine] list of cuisine
  /// if unsuccessful the response will be [Failure]
  Future<List<Cuisine>> getCuisineList();
}

class RemoteDataSourceImp implements RemoteDataSource {
  final FirebaseFirestore firestore;

  RemoteDataSourceImp({required this.firestore});

  @override
  Future<List<Food>> fetchFoodList() async {
    try {
      List<Food> foodList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('foods').get();

      for(var document in snapshot.docs){
        final food = Food.fromJson(document);
        foodList.add(food);
      }

      return foodList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategoryList() async {
    try {
      List<Category> catagoryList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('catagories').get();


      for(var document in snapshot.docs){
        final catagory = Category.fromJson(document);
        catagoryList.add(catagory);
      }

      return catagoryList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Cuisine>> getCuisineList() async {
    try {
      List<Cuisine> cuisineList = [];
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('cuisines').get();

      for(var document in snapshot.docs){
        final cuisine = Cuisine.fromJson(document);
        cuisineList.add(cuisine);
      }

      return cuisineList;
    } catch (e) {
      rethrow;
    }
  }
}
