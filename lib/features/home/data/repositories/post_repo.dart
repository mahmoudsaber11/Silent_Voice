import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/features/home/data/entities/post_params.dart';

abstract class PostRepo {
  Future<TaskSnapshot> uploadPost({File? postImage});

  Future<DocumentReference<Map<String, dynamic>>> createNewPost({
    required PostParams postParams,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

  Future<void> deletePost({required String postId});

  Future<void> likePost({required String postId});
  Future<DocumentSnapshot<Map<String, dynamic>>> likedByMe({
    String? postId,
  });
}
