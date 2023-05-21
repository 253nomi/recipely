import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/get_food_list.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_constants/mock_constants.dart';
import '../../../mocks/mock_error_repository.dart';
import '../../../mocks/mock_repository.dart';

void main() {
  late GetFoodList usecase;
  late Repository repository;
  late Repository errorRepository;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('Should return food details', () async {
    // Arrange
    usecase = GetFoodList(repository);

    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isRight());
    result.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, MOCK_FOOD_DETAILS));
  });

  test('Should return error', () async {
    // Arrange
    usecase = GetFoodList(errorRepository);

    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isLeft());
    result.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
  });
}
