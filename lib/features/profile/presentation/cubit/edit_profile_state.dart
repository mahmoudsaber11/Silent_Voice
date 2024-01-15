import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class UpdateUserLoading extends EditProfileState {
  const UpdateUserLoading();
}

class UpdateUserSuccess extends EditProfileState {
  const UpdateUserSuccess();
}

class UpdateUserError extends EditProfileState {
  final String error;

  UpdateUserError({required this.error});
  @override
  List<Object?> get props => [error];
}

class GetProfileImageSuccess extends EditProfileState {
  final File profileImage;

  GetProfileImageSuccess({required this.profileImage});
  @override
  List<Object> get props => [profileImage];
}

class GetProfileImageError extends EditProfileState {
  final String error;

  GetProfileImageError({required this.error});
  @override
  List<Object> get props => [error];
}

class UploadImageLoading extends EditProfileState {
  const UploadImageLoading();
}

class UploadImageSuccess extends EditProfileState {
  final String image;

  const UploadImageSuccess({required this.image});

  @override
  List<Object> get props => [image];
}

class UploadImageError extends EditProfileState {
  final String error;

  const UploadImageError({required this.error});

  @override
  List<Object> get props => [error];
}
