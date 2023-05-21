import 'package:dartz/dartz.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/food.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';

class GetFoodList implements UseCase<List<Food>, NoParams> {
  final Repository repository;

  GetFoodList(this.repository);

  @override
  Future<Either<Failure, List<Food>>> call(NoParams params) {
    return repository.getFoodList();
  }
}
