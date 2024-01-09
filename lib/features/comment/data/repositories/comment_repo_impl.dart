import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/comment/data/entities/comment_post_params.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';
import 'package:social_app/features/comment/data/repositories/comment_repo.dart';

class CommentRepoImpl implements CommentRepo {
  @override
  Future<DocumentReference<Map<String, dynamic>>> commentPost(
      {required CommentPostParams commentPostParams}) async {
    CommentModel commentModel = CommentModel(
      name: Helper.userModel!.name,
      image: Helper.userModel!.image,
      uId: Helper.userModel!.uId,
      commentText: commentPostParams.commentText,
      time: commentPostParams.time,
      date: commentPostParams.date,
      dateTime: FieldValue.serverTimestamp(),
    );
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(commentPostParams.postId)
        .collection('comments')
        .add(commentModel.toMap());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getComments(
      {required String postId}) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection("comments")
        .orderBy('dateTime')
        .snapshots();
  }
}
