import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostState {
  const PostsInitial();
}

class CreatePostLoading extends PostState {
  const CreatePostLoading();
}

class CreatePostSuccess extends PostState {
  const CreatePostSuccess();
}

class CreatePostError extends PostState {
  final String error;

  const CreatePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetPostsLoading extends PostState {
  const GetPostsLoading();
}

class GetPostsSuccess extends PostState {
  const GetPostsSuccess();
}

class GetPostsError extends PostState {
  final String error;

  const GetPostsError({required this.error});

  @override
  List<Object> get props => [error];
}

class UploadPostLoading extends PostState {
  const UploadPostLoading();
}

class UploadPostSuccess extends PostState {
  final String image;

  const UploadPostSuccess({required this.image});

  @override
  List<Object> get props => [image];
}

class UploadPostError extends PostState {
  final String error;

  const UploadPostError({required this.error});

  @override
  List<Object> get props => [error];
}

class DeletePostLoading extends PostState {
  const DeletePostLoading();
}

class DeletePostSuccess extends PostState {
  const DeletePostSuccess();
}

class DeletePostError extends PostState {
  final String error;

  const DeletePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class LikePostSuccess extends PostState {
  const LikePostSuccess();
}

class LikePostError extends PostState {
  final String error;

  const LikePostError({required this.error});

  @override
  List<Object> get props => [error];
}

class LikedByMeLoading extends PostState {
  const LikedByMeLoading();
}

class LikedByMeSuccess extends PostState {
  const LikedByMeSuccess();
}

class LikedByMeError extends PostState {
  final String error;

  const LikedByMeError({required this.error});

  @override
  List<Object> get props => [error];
}

class PostImageSuccess extends PostState {
  const PostImageSuccess();
}

class PostImageError extends PostState {
  const PostImageError();
}

class RemovePostImage extends PostState {}
