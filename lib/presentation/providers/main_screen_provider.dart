import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/domain/usecases/get_category_list.dart';
import 'package:receipe_task/domain/usecases/get_cuisine_list.dart';
import 'package:receipe_task/domain/usecases/get_food_list.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';

class MainScreenProvider extends ChangeNotifier {
  final GetCuisineList _getCuisineList;
  final GetCategoryList _getCategoryList;
  final GetFoodList _getFoodList;

  List<Food> foodListToSearch = [];
  List<Food> foodList = [];
  List<Category> categoryList = [];
  List<Category> selectedCategoryList = [];
  List<Cuisine> cuisineList = [];
  List<Cuisine> selectedCuisineList = [];

  MainScreenProvider({required GetFoodList getFoodList, required GetCategoryList getCategoryList, required GetCuisineList getCuisineList})
      : _getFoodList = getFoodList,
        _getCategoryList = getCategoryList,
        _getCuisineList = getCuisineList;

  ValueChanged<String>? onError;
  VoidCallback? toggleShowLoader;

  void handleError(Either<Failure, dynamic> either) {
    toggleShowLoader?.call();
    either.fold((l) {
      onError?.call(l.message);
    }, (r) => null);
  }

  Future<void> getDataFromServer() async {
    if (!(await getCatagoryListFromServer())) {
      return;
    }

    if (!(await getCuisineListFromServer())) {
      return;
    }

    await getFoodListFromServer();
    notifyListeners();
  }

  Future<bool> getFoodListFromServer() async {
    final foodListEither = await _getFoodList.call(NoParams());
    if (foodListEither.isLeft()) {
      handleError(foodListEither);
      return false;
    }

    foodList.addAll(foodListEither.getOrElse(() => []));
    foodListToSearch.addAll(foodList);
    return true;
  }

  Future<bool> getCatagoryListFromServer() async {
    final catagoryListEither = await _getCategoryList.call(NoParams());
    if (catagoryListEither.isLeft()) {
      handleError(catagoryListEither);
      return false;
    }

    categoryList.addAll(catagoryListEither.getOrElse(() => []));
    return true;
  }

  Future<bool> getCuisineListFromServer() async {
    final cuisineListEither = await _getCuisineList.call(NoParams());
    if (cuisineListEither.isLeft()) {
      handleError(cuisineListEither);
      return false;
    }
    cuisineList.addAll(cuisineListEither.getOrElse(() => []));
    return true;
  }

  void searchFoods(String val) {
    if (val.isEmpty && selectedCategoryList.isEmpty && selectedCuisineList.isEmpty) {
      print('Empty Search in All Food');
      foodList.clear();
      foodList.addAll(foodListToSearch);
      notifyListeners();
      return;
    }


    else if (val.isEmpty && (selectedCategoryList.isNotEmpty || selectedCuisineList.isNotEmpty)) {
      print('Empty Search in Filter Food');
      applyFilters();
      return;
    }


    else if (val.isNotEmpty && (selectedCategoryList.isNotEmpty || selectedCuisineList.isNotEmpty)) {
      print('Search in Filter Food');
      List <Food> filteredFood = foodList.where((element) => element.name.toLowerCase().contains(val.toLowerCase().trim())).toList();
      foodList.clear();
      foodList.addAll(filteredFood);
      foodList.toSet().toList();
      notifyListeners();
      return;
    }

    print('Search in All Food');
    foodList.clear();
    foodList.addAll(foodListToSearch.where((element) => element.name.toLowerCase().contains(val.toLowerCase().trim())).toList());
    notifyListeners();
  }

  void addOrRemoveSelectedCategory(Category cat) {
    final notSelected = selectedCategoryList.where((element) => element.name.toLowerCase() == cat.name.toLowerCase()).toList().isEmpty;
    if (notSelected) {
      selectedCategoryList.add(cat);
      notifyListeners();
      return;
    }

    selectedCategoryList.remove(cat);
    notifyListeners();
  }

  void addOrRemoveSelectedCuisine(Cuisine cui) {
    final notSelected = selectedCuisineList.where((element) => element.name.toLowerCase() == cui.name.toLowerCase()).toList().isEmpty;
    if (notSelected) {
      selectedCuisineList.add(cui);
      notifyListeners();
      return;
    }

    selectedCuisineList.remove(cui);
    notifyListeners();
  }

  void clearFilters() {
    selectedCategoryList.clear();
    selectedCuisineList.clear();
    foodList.clear();
    foodList.addAll(foodListToSearch);
    notifyListeners();
  }

  void applyFilters() {
    if (selectedCategoryList.isEmpty && selectedCuisineList.isEmpty) {
      foodList.addAll(foodListToSearch);
      notifyListeners();
      return;
    }

    foodList.clear();

    for (int i = 0; i < selectedCuisineList.length; i++) {
      foodList.addAll(foodListToSearch.where((element) => element.cuisineId == selectedCuisineList[i].id).toList());
    }

    for (int i = 0; i < selectedCategoryList.length; i++) {
      foodList.addAll(foodListToSearch.where((element) => element.categoryId == selectedCategoryList[i].id).toList());
    }

    foodList.toSet().toList();
    notifyListeners();
  }
}
