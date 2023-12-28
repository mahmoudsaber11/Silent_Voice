import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/data/repositories/sign_in/sign_in_repo.dart';

class SignInRepoImpl implements SignInRepo {
  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
