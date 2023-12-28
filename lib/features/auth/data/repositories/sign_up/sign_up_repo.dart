import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepo {
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  });

  Future<void> createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  });
}
