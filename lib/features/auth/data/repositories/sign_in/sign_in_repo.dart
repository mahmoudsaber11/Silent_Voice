import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRepo {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });
}
