import 'package:dartz/dartz.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/cuisine.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';

class GetCuisineList implements UseCase<List<Cuisine>, NoParams> {
  final Repository repository;

  GetCuisineList(this.repository);

  @override
  Future<Either<Failure, List<Cuisine>>> call(NoParams params) {
    return repository.getCuisineList();
  }
}
