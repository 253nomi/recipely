import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/get_category_list.dart';
import 'package:receipe_task/domain/usecases/usecase.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_constants/mock_constants.dart';
import '../../../mocks/mock_error_repository.dart';
import '../../../mocks/mock_repository.dart';

void main() {
  late GetCategoryList usecase;
  late Repository repository;
  late Repository errorRepository;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('Should return category details', () async {
    // Arrange
    usecase = GetCategoryList(repository);

    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isRight());
    result.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, MOCK_CATEGORY_DETAILS));
  });

  test('Should return error', () async {
    // Arrange
    usecase = GetCategoryList(errorRepository);

    // Act
    var result = await usecase.call(NoParams());

    // assert
    expect(true, result.isLeft());
    result.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
  });
}
