import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/utils/constants/constants.dart';

class MockErrorRepository extends Repository {
  @override
  Future<Either<Failure, List<Food>>> getFoodList() async {
    return const Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, User>> loginWithFirebase(LoginWithFirebaseParams params) async {
    return const Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoryList() async{
    return const Left(ServerFailure(SOMETHING_WENT_WRONG));
  }

  @override
  Future<Either<Failure, List<Cuisine>>> getCuisineList() async{
    return const Left(ServerFailure(SOMETHING_WENT_WRONG));
  }
}
