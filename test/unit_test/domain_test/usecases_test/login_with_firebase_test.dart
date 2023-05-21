import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/login_with_firebase_usecase.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_constants/mock_constants.dart';
import '../../../mocks/mock_error_repository.dart';
import '../../../mocks/mock_repository.dart';
import '../../../mocks/mock_user.dart';

void main() {
  late LoginWithFirebaseUseCase usecase;
  late Repository repository;
  late Repository errorRepository;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('Should return firebase user', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(repository);

    // Act
    var result = await usecase.call(MOCK_CREDENTIALS);

    // assert
    expect(true, result.isRight());
    result.fold((l) => throw SOMETHING_WENT_WRONG, (r) => expect(r, isA<MockUser>()));
  });

  test('Should return error', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(errorRepository);

    // Act
    var result = await usecase.call(MOCK_CREDENTIALS);

    // assert
    expect(true, result.isLeft());
    result.fold((l) => expect(const ServerFailure(SOMETHING_WENT_WRONG), l), (r) => throw SOMETHING_WENT_WRONG);
  });
}
