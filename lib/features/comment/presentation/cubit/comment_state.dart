import 'package:equatable/equatable.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {
  const CommentsInitial();
}

class CommentPostLoading extends CommentsState {
  const CommentPostLoading();
}

class CommentPostSuccess extends CommentsState {
  const CommentPostSuccess();
}

class CommentPostError extends CommentsState {
  final String error;

  const CommentPostError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetCommentsSuccess extends CommentsState {
  final List<CommentModel> comments;

  const GetCommentsSuccess({required this.comments});

  @override
  List<Object> get props => [comments];
}

class GetCommentsError extends CommentsState {
  final String error;

  const GetCommentsError({required this.error});

  @override
  List<Object> get props => [error];
}
