import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/comment/presentation/widgets/build_comment.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({super.key, required this.comments});

  final List<CommentModel> comments;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30.w,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => BuildComment(
          comment: comments[index],
        ),
        separatorBuilder: (context, index) => SizedBox(height: 25.h),
        itemCount: comments.length,
      ),
    );
  }
}
