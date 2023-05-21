import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/get_cuisine_list.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_contants/mock_constants.dart';
import '../../../mocks/mock_error_repository.dart';
import '../../../mocks/mock_repository.dart';

void main() {
  late GetCuisineList usecase;
  late Repository repository;
  late Repository errorRepository;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('Should return cuisine details', () async {
    // Arrange
    usecase = GetCuisineList(repository);

    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isRight());
    result.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, MOCK_CUISINE_DETAILS));
  });

  test('Should return error', () async {
    // Arrange
    usecase = GetCuisineList(errorRepository);

    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isLeft());
    result.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
  });
}
