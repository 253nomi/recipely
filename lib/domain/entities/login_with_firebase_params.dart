import 'package:equatable/equatable.dart';

class LoginWithFirebaseParams extends Equatable {
  final String email;
  final String password;

  const LoginWithFirebaseParams({required this.email, required this.password});

  factory LoginWithFirebaseParams.empty() {
    return const LoginWithFirebaseParams(email: '', password: '');
  }

  @override
  List<Object?> get props => [email, password];
}

class LoginWithFirebaseResponse extends Equatable {
  final String email;
  final String password;

  const LoginWithFirebaseResponse({required this.email, required this.password});

  factory LoginWithFirebaseResponse.empty() {
    return const LoginWithFirebaseResponse(email: '', password: '');
  }

  @override
  List<Object?> get props => [email, password];
}
