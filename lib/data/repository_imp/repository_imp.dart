import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/data_sources/auth_data_sources.dart';
import 'package:receipe_task/data/data_sources/remote_data_sources.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import 'package:receipe_task/utils/network_info.dart';

class RepositoryImp implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final AuthDataSource _authDataSource;

  RepositoryImp({required NetworkInfo networkInfo, required AuthDataSource authDataSource, required RemoteDataSource remoteDataSource})
      : _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource,
        _authDataSource = authDataSource;

  Either<Failure, User> handleFirebaseAuthException(FirebaseAuthException e) {
    return Left(ServerFailure(e.message));
  }

  @override
  Future<Either<Failure, User>> loginWithFirebase(LoginWithFirebaseParams params) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(NO_INTERNET));
    }

    try {
      return Right(await _authDataSource.loginWithFirebase(params));
    } on FirebaseAuthException catch (e) {
      return handleFirebaseAuthException(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Food>>> getFoodList() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(NO_INTERNET));
    }

    try {
      return Right(await _remoteDataSource.fetchFoodList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategoryList() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(NO_INTERNET));
    }

    try {
      return Right(await _remoteDataSource.getCategoryList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Cuisine>>> getCuisineList() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(NO_INTERNET));
    }

    try {
      return Right(await _remoteDataSource.getCuisineList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
