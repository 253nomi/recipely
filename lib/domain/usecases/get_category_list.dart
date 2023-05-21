import 'package:dartz/dartz.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/category.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';

class GetCategoryList implements UseCase<List<Category>, NoParams> {
  final Repository repository;

  GetCategoryList(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return repository.getCategoryList();
  }
}