import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/domain/usecases/login_with_firebase_usecase.dart';
import 'package:receipe_task/utils/validators/textfiled_validator.dart';

class LoginProvider extends ChangeNotifier {
  final LoginWithFirebaseUseCase _loginWithFirebaseUseCase;

  String? emailErrorText;
  String? passErrorText;
  ValueChanged<String>? onError;
  VoidCallback? toggleShowLoader;

  void handleError(Either<Failure, dynamic> either) {
    toggleShowLoader?.call();
    either.fold((l) {
      onError?.call(l.message);
    }, (r) => null);
  }

  LoginProvider({required LoginWithFirebaseUseCase loginWithFirebaseUseCase}) : _loginWithFirebaseUseCase = loginWithFirebaseUseCase;

  Future<bool> pressLoginButton(LoginWithFirebaseParams params) async {
    toggleShowLoader?.call();
    final loginResultEither = await _loginWithFirebaseUseCase.call(params);
    if (loginResultEither.isLeft()) {
      handleError(loginResultEither);
      return false;
    }

    toggleShowLoader?.call();
    return true;
  }

  void validateEmailField(String? val) {
    if (val == null || val.isEmpty) {
      emailErrorText = null;
      notifyListeners();
      return;
    }

    if (val.isNotEmpty) {
      emailErrorText = TextValidators.validateEmail(val);
      notifyListeners();
    }
  }

  void validatePasswordField(String? val) {
    if (val == null || val.isEmpty) {
      passErrorText = null;
      notifyListeners();
      return;
    }

    if (val.isNotEmpty) {
      passErrorText = TextValidators.passwordValidated(val);
      notifyListeners();
    }
  }
}
