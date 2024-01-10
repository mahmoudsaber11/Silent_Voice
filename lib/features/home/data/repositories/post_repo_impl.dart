import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/home/data/entities/post_params.dart';
import 'package:social_app/features/home/data/models/like_model.dart';
import 'package:social_app/features/home/data/models/post_model.dart';
import 'package:social_app/features/home/data/repositories/post_repo.dart';

class PostRepoImpl implements PostRepo {
  @override
  Future<DocumentReference<Map<String, dynamic>>> createNewPost(
      {required PostParams postParams}) async {
    final PostModel postModel = PostModel(
        name: Helper.userModel!.name,
        image: Helper.userModel!.image,
        uId: Helper.userModel!.uId,
        text: postParams.text,
        postImage: postParams.postImage ?? '',
        likes: 0,
        comments: 0,
        time: postParams.time,
        date: postParams.date,
        dateTime: Timestamp.now());
    return await FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap());
  }

  @override
  Future<TaskSnapshot> uploadPost({File? postImage}) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  @override
  Future<void> deletePost({required String postId}) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete();
  }

  @override
  Future<void> likePost({required String postId}) async {
    final LikesModel likesModel = LikesModel(
      uId: Helper.userModel!.uId,
      name: Helper.userModel!.name,
      image: Helper.userModel!.image,
      dateTime: Timestamp.now(),
    );
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(Helper.userModel!.uId)
        .set(likesModel.toMap());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> likedByMe({
    String? postId,
  }) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get();
  }
}
