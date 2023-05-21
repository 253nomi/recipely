import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/login_with_firebase_usecase.dart';
import 'package:receipe_task/presentation/providers/login_provider.dart';
import 'package:receipe_task/presentation/screens/splash_screen.dart';
import '../../mocks/mock_repository.dart';
import '../helpers/extensions.dart';

void main() {
  late LoginWithFirebaseUseCase usecase;
  late Repository repository;
  late LoginProvider provider;

  setUp(() {
    repository = MockRepository();
    usecase = LoginWithFirebaseUseCase(repository);
    provider = LoginProvider(loginWithFirebaseUseCase: usecase);
  });

  testWidgets('Should check text on splash screen', (WidgetTester tester) async {

    GetIt.I.registerSingleton(provider);

    final recipelyButtonTextFinder = find.text('Recipely');

    await tester.setScreenSize();
    await tester.testAppForWidgetTesting(const RecipelySplashScreen());

    expect(recipelyButtonTextFinder, findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    expect(recipelyButtonTextFinder, findsOneWidget);

  });
}
