import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';

class LoginWithFirebaseUseCase implements UseCase<User, LoginWithFirebaseParams> {
  final Repository repository;

  LoginWithFirebaseUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginWithFirebaseParams params) {
    return repository.loginWithFirebase(params);
  }
}
