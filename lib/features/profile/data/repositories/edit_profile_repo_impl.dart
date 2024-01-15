import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/profile/data/entities/update_user_params.dart';
import 'package:social_app/features/profile/data/repositories/edit_profile_repo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileRepoImpl implements EditProfileRepo {
  @override
  Future<XFile?> getProfileImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(source: source);
  }

  @override
  Future<TaskSnapshot> uploadProfileImage({File? profileImage}) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage);
  }

  @override
  Future<void> updateUser({required UpdateUserParams updateUserParams}) async {
    UserModel model = UserModel(
      name: updateUserParams.name,
      phone: updateUserParams.phone,
      bio: updateUserParams.bio,
      email: Helper.userModel!.email,
      uId: Helper.userModel!.uId,
      image: updateUserParams.image ?? Helper.userModel!.image,
    );
    Helper.userModel = model;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.userModel!.uId)
        .update(model.toMap());
  }
}
