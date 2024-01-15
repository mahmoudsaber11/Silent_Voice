import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/comment/data/entities/comment_post_params.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';
import 'package:social_app/features/comment/data/repositories/comment_repo.dart';
import 'package:social_app/features/comment/presentation/cubit/comment_state.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';

class CommentCubit extends Cubit<CommentsState> {
  CommentCubit({required this.commentRepo}) : super(const CommentsInitial());
  final CommentRepo commentRepo;

  void commentPost(
      {required CommentPostParams params, required BuildContext context}) {
    emit(const CommentPostLoading());
    commentRepo.commentPost(commentPostParams: params).then((success) {
      BlocProvider.of<PostCubit>(context).getPosts();
      emit(const CommentPostSuccess());
    }).catchError((error) {
      emit(CommentPostError(error: error.toString()));
    });
  }

  List<CommentModel> comments = [];
  void getComments({required String postId}) {
    commentRepo.getComments(postId: postId).listen((event) {
      comments.clear();
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
        emit(GetCommentsSuccess(comments: comments));
      }
    });
  }
}
