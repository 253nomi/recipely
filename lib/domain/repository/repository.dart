import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';

abstract class Repository {
  /// This method will login into firebase
  /// Input : [params] contains email and password
  /// Output : if operation successful returns [User] firebase user
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, User>> loginWithFirebase(LoginWithFirebaseParams params);

  /// This method will return food list from firestore
  /// Output : if operation successful returns [Food] list of food
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, List<Food>>> getFoodList();

  /// This method will return cuisine list from firestore
  /// Output : if operation successful returns [Cuisine] list of cuisine
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, List<Cuisine>>> getCuisineList();

  /// This method will return category list from firestore
  /// Output : if operation successful returns [Category] list of category
  /// if unsuccessful the response will be [Failure]
  Future<Either<Failure, List<Category>>> getCategoryList();
}
