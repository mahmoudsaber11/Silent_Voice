import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/features/comment/data/entities/comment_post_params.dart';

abstract class CommentRepo {
  Future<DocumentReference<Map<String, dynamic>>> commentPost(
      {required CommentPostParams commentPostParams});
  Stream<QuerySnapshot<Map<String, dynamic>>> getComments({
    required String postId,
  });
}
