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
        cover:
            'https://img.freepik.com/free-photo/indoor-shot-positive-bearded-male-casual-red-t-shirt-points-with-index-finger-aside_273609-16274.jpg?w=740&t=st=1678780585~exp=1678781185~hmac=70a75fbb58f7d113287cf94ca6d24c9665bca9061e309b447a4e211fdf3121df',
        uId: uId,
        bio: 'Write you bio ...');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap());
  }
}
