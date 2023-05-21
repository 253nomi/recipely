import 'package:flutter_test/flutter_test.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/login_with_firebase_usecase.dart';
import 'package:receipe_task/presentation/providers/login_provider.dart';
import 'package:receipe_task/utils/constants/constants.dart';
import '../../../mock_constants/mock_constants.dart';
import '../../../mocks/mock_error_repository.dart';
import '../../../mocks/mock_repository.dart';

void main() {
  late LoginWithFirebaseUseCase usecase;
  late Repository repository;
  late Repository errorRepository;
  late LoginProvider loginProvider;

  setUp(() {
    repository = MockRepository();
    errorRepository = MockErrorRepository();
  });

  test('should return true on login', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(repository);
    loginProvider = LoginProvider(loginWithFirebaseUseCase: usecase);

    // Act
    final result = await loginProvider.pressLoginButton(MOCK_CREDENTIALS);

    // assert
    expect(true, result);
  });

  test('should return false on login', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(errorRepository);
    loginProvider = LoginProvider(loginWithFirebaseUseCase: usecase);

    // Act
    final result = await loginProvider.pressLoginButton(MOCK_CREDENTIALS);

    // assert
    expect(false, result);
    loginProvider.onError = (_) {
      expect(true, true);
      expect(_, SOMETHING_WENT_WRONG);
    };
  });


  test('should return error text null on email verification', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(repository);
    loginProvider = LoginProvider(loginWithFirebaseUseCase: usecase);

    // Act
    loginProvider.validateEmailField('nomanijaz253@gmail.com');

    // assert
    expect(loginProvider.emailErrorText, null);
  });


  test('should return error text on email verification', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(repository);
    loginProvider = LoginProvider(loginWithFirebaseUseCase: usecase);

    // Act
     loginProvider.validateEmailField('nomanijaz253gmail.om');

    // assert
    expect(loginProvider.emailErrorText, 'Invalid Email');
  });


  test('should return error text null on password verification', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(repository);
    loginProvider = LoginProvider(loginWithFirebaseUseCase: usecase);

    // Act
    loginProvider.validatePasswordField('12345678');

    // assert
    expect(loginProvider.passErrorText, null);
  });


  test('should return error text on password verification', () async {
    // Arrange
    usecase = LoginWithFirebaseUseCase(repository);
    loginProvider = LoginProvider(loginWithFirebaseUseCase: usecase);

    // Act
    loginProvider.validatePasswordField('12345');

    // assert
    expect(loginProvider.passErrorText, 'Password should be 8 characters');
  });
}
