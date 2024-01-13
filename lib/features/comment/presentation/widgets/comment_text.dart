import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';

class CommentText extends StatelessWidget {
  const CommentText({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w),
      width: MediaQuery.of(context).size.width * .6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${comment.name}',
            style: AppTextStyles.textStyle16Bold,
          ),
          Text(
            '${comment.commentText}',
          ),
        ],
      ),
    );
  }
}
