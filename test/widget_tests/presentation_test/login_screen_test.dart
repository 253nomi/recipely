import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:receipe_task/domain/repository/repository.dart';
import 'package:receipe_task/domain/usecases/login_with_firebase_usecase.dart';
import 'package:receipe_task/presentation/providers/login_provider.dart';
import 'package:receipe_task/presentation/screens/login_screen.dart';
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

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('should test main login screen', (WidgetTester tester) async {
    GetIt.I.registerSingleton(provider);

    final loginTextFinder = find.text('Login');
    final emailTextFieldFinder = find.byKey(const ValueKey('email_text_field'));
    final passwordTextFieldFinder = find.byKey(const ValueKey('password_text_field'));
    final loginWithGoogleTextFinder = find.text('Login with Google');
    final loginWithFacebookTextFinder = find.text('Login with Facebook');
    final continueWIthTextFinder = find.text('or continue with?');

    await tester.setScreenSize();
    await tester.testAppForWidgetTesting(const RecipelyLoginScreen());

    expect(loginTextFinder, findsWidgets);
    expect(emailTextFieldFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsOneWidget);
    expect(loginWithGoogleTextFinder, findsOneWidget);
    expect(loginWithFacebookTextFinder, findsOneWidget);
    expect(continueWIthTextFinder, findsOneWidget);
  });

  testWidgets('should test main login screen content', (WidgetTester tester) async {
    GetIt.I.registerSingleton(provider);

    final loginTextFinder = find.text('Login');
    final emailTextFieldFinder = find.byKey(const ValueKey('email_text_field'));
    final passwordTextFieldFinder = find.byKey(const ValueKey('password_text_field'));
    final loginWithGoogleTextFinder = find.text('Login with Google');
    final loginWithFacebookTextFinder = find.text('Login with Facebook');
    final continueWIthTextFinder = find.text('or continue with?');

    await tester.setScreenSize();
    await tester.testAppForWidgetTesting(ChangeNotifierProvider.value(value: provider, child: const RecipelyLoginScreenContent()));

    expect(loginTextFinder, findsWidgets);
    expect(emailTextFieldFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsOneWidget);
    expect(loginWithGoogleTextFinder, findsOneWidget);
    expect(loginWithFacebookTextFinder, findsOneWidget);
    expect(continueWIthTextFinder, findsOneWidget);
  });
}
