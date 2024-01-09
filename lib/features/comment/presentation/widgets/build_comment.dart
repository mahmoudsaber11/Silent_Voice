import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/comment/presentation/widgets/comment_text.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';

class BuildComment extends StatelessWidget {
  const BuildComment({
    super.key,
    required this.comment,
  });
  final CommentModel comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 25, backgroundImage: NetworkImage('${comment.image}')),
            SizedBox(
              width: 5.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                comment.commentText != null
                    ? CommentText(comment: comment)
                    : const SizedBox(
                        height: 0,
                      ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: Text(
                    '${comment.time}',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
