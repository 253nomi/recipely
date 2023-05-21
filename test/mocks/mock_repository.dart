import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import '../mock_constants/mock_constants.dart';
import 'mock_user.dart';

class MockRepository implements Repository {
  @override
  Future<Either<Failure, List<Food>>> getFoodList() async {
    return const Right(MOCK_FOOD_DETAILS);
  }

  @override
  Future<Either<Failure, User>> loginWithFirebase(LoginWithFirebaseParams params) async {
    return Right(MockUser());
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoryList() async {
    return const Right(MOCK_CATEGORY_DETAILS);
  }

  @override
  Future<Either<Failure, List<Cuisine>>> getCuisineList() async {
    return const Right(MOCK_CUISINE_DETAILS);
  }
}
