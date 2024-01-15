import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';

class CommentAppBar extends StatelessWidget {
  const CommentAppBar({
    super.key,
    required this.comments,
  });

  final List<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 55.h, left: 10.w, right: 10.w, bottom: 10.w),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                context.getBack();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              )),
          SizedBox(
            width: 60.w,
          ),
          Text(
            "Comments(${comments.length})",
            style: AppTextStyles.textStyle20,
          ),
        ],
      ),
    );
  }
}
