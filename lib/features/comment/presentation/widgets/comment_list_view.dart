import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/comment/presentation/view/comment_view.dart';
import 'package:social_app/models/social_app/comment_model.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({Key? key, required this.comments}) : super(key: key);

  final List<CommentModel> comments;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, bottom: 50.h),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .65,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => BuildComment(
            comment: comments[index],
          ),
          separatorBuilder: (context, index) => SizedBox(height: 20.h),
          itemCount: comments.length,
        ),
      ),
    );
  }
}
