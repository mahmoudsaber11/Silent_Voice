import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/auth/data/repositories/sign_up/sign_up_repo.dart';

class SignUpRepoImpl implements SignUpRepo {
  @override
  Future<UserCredential> signUp(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> createUser(
      {required String name,
      required String email,
      required String phone,
      required String uId}) async {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        image:
            'https://img.freepik.com/free-photo/full-shot-woman-reading-with-smartphone_23-2149629602.jpg?size=626&ext=jpg&ga=GA1.2.773475287.1678416458&semt=ais',
        uId: uId,
        bio: 'Write you bio ...');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap());
  }
}
