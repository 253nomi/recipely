import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/data_sources/auth_data_sources.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/utils/constants/constants.dart';

class MockAuthDataSourceError implements AuthDataSource {
  @override
  Future<User> loginWithFirebase(LoginWithFirebaseParams params) async {
    throw SOMETHING_WENT_WRONG;
  }
}
