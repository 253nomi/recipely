import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/data_sources/auth_data_sources.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';

import 'mock_user.dart';

class MockAuthDataSource implements AuthDataSource {
  @override
  Future<User> loginWithFirebase(LoginWithFirebaseParams params) async {
    return MockUser();
  }
}
