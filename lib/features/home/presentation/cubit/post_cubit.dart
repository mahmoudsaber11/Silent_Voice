import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/home/data/entities/post_params.dart';
import 'package:social_app/features/home/data/models/post_model.dart';
import 'package:social_app/features/home/data/repositories/post_repo.dart';
import 'package:social_app/features/home/presentation/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepo}) : super(const PostsInitial());
  final PostRepo postRepo;

  void createNewPost({required PostParams postParams}) {
    emit(const CreatePostLoading());
    postRepo.createNewPost(postParams: postParams).then((value) {
      postImage = null;
      emit(const CreatePostSuccess());
      getPosts();
    }).catchError((error) {
      emit(CreatePostError(error: error.toString()));
    });
  }

  File? postImage;
  void uploadPost({required PostParams postParams}) {
    emit(const UploadPostLoading());
    postRepo.uploadPost(postImage: postImage).then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(
            postParams: PostParams(
                time: postParams.time,
                postImage: value,
                date: postParams.date,
                text: postParams.text));
        postImage = null;
        emit(UploadPostSuccess(image: value));
      }).catchError((error) {
        emit(UploadPostError(error: error.toString()));
      });
    }).catchError((error) {
      emit(UploadPostError(error: error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  Future<void> getPosts() async {
    emit(const GetPostsLoading());
    postRepo.getPosts().listen((event) {
      posts = [];
      // ignore: avoid_function_literals_in_foreach_calls
      event.docs.forEach((element) async {
        posts.add(PostModel.fromJson(element.data()));
        var likes = await element.reference.collection('likes').get();
        var comments = await element.reference.collection('comments').get();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(element.id)
            .update(({
              'likes': likes.docs.length,
              'comments': comments.docs.length,
              'postId': element.id,
            }));
      });
      emit(GetPostsSuccess(posts: posts));
    });
  }

  void deletePost({required String postId}) {
    emit(const DeletePostLoading());
    postRepo.deletePost(postId: postId).then((value) {
      getPosts();
      emit(const DeletePostSuccess());
    }).catchError((error) {
      emit(DeletePostError(error: error.toString()));
    });
  }

  void likePost({required String postId}) {
    postRepo.likePost(postId: postId).then((value) {
      getPosts();
      emit(const LikePostSuccess());
    }).catchError((error) {
      emit(LikePostError(error: error.toString()));
    });
  }

  Future<bool> likedByMe(
    String? postId,
  ) {
    emit(const LikedByMeLoading());
    dynamic isLikedByMe = false;
    postRepo.likedByMe().then((event) async {
      var likes = await event.reference.collection('likes').get();
      for (var element in likes.docs) {
        if (element.id == Helper.userModel!.uId) {
          isLikedByMe = true;
          // disLikePost(postId);
        }
      }
      if (isLikedByMe == false) {
        likePost(
          postId: postId!,
        );
      }
      emit(LikedByMeSuccess(likedPosts: posts));
    }).catchError((error) {
      emit(LikedByMeError(error: error.toString()));
    });
    return isLikedByMe;
  }

  ImagePicker picker = ImagePicker();
  void getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImageSuccess(postImage: postImage!));
    } else {
      emit(PostImageError());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImage());
  }
}
