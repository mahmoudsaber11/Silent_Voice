import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/features/profile/data/entities/update_user_params.dart';
import 'package:social_app/features/profile/data/repositories/edit_profile_repo.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({required this.editProfileRepo})
      : super(const EditProfileInitial());
  final EditProfileRepo editProfileRepo;

  void updateUser({
    required UpdateUserParams updateUserParams,
  }) {
    emit(const UpdateUserLoading());
    editProfileRepo
        .updateUser(updateUserParams: updateUserParams)
        .then((value) {
      emit(const UpdateUserSuccess());
    }).catchError((error) {
      emit(UpdateUserError(error: error));
    });
  }

  File? profileImage;
  void getProfileImage({required ImageSource source}) async {
    editProfileRepo.getProfileImage(source: source).then((value) {
      if (value != null) {
        profileImage = File(value.path);
        emit(GetProfileImageSuccess(profileImage: profileImage!));
      }
    }).catchError((error) {
      emit(GetProfileImageError(error: error));
    });
  }

  void uploadProfileImage({
    required UpdateUserParams updateUserParams,
  }) {
    emit(const UploadImageLoading());

    editProfileRepo
        .uploadProfileImage(profileImage: profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadImageSuccess(image: value));
        updateUser(
            updateUserParams: UpdateUserParams(
                image: value,
                name: updateUserParams.name,
                phone: updateUserParams.phone,
                bio: updateUserParams.bio));
      }).catchError((error) {
        emit(UploadImageError(error: error));
      });
    }).catchError((error) {
      emit(UploadImageError(error: error));
    });
  }
}
