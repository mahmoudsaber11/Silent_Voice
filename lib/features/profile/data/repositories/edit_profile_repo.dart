import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/profile/data/entities/update_user_params.dart';

abstract class EditProfileRepo {
  Future<XFile?> getProfileImage({required ImageSource source});
  Future<TaskSnapshot> uploadProfileImage({
    File? profileImage,
  });
  Future<void> updateUser({required UpdateUserParams updateUserParams});
}
