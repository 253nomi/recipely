import 'package:firebase_auth/firebase_auth.dart';
import 'package:receipe_task/data/failures/failure.dart';
import 'package:receipe_task/domain/entities/login_with_firebase_params.dart';
import 'package:receipe_task/utils/constants/constants.dart';

abstract class AuthDataSource {
  /// This method will login into firebase
  /// Input : [params] contains email and password
  /// Output : if operation successful returns [User] firebase user
  /// if unsuccessful the response will be [Failure]
  Future<User> loginWithFirebase(LoginWithFirebaseParams params);
}

class AuthDataSourceImp implements AuthDataSource {
  final FirebaseAuth firebaseAuth;

  AuthDataSourceImp({required this.firebaseAuth});

  @override
  Future<User> loginWithFirebase(LoginWithFirebaseParams params) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      User? user = userCredential.user;

      if (user == null) {
        throw const ServerFailure(SOMETHING_WENT_WRONG);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
