import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';
import 'package:social_app/features/home/presentation/widgets/comment_and_like_section.dart';
import 'package:social_app/features/home/presentation/widgets/upper_section.dart';
import 'package:social_app/features/create_post/data/models/post_model.dart';

class CustomPostItem extends StatelessWidget {
  final PostModel? postModel;
  const CustomPostItem({
    super.key,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context) {
    List<CommentModel> comments = SocialCubit.get(context).comments;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UpperSection(postModel: postModel!),
            SizedBox(
              height: 15.h,
            ),
            Text(
              '${postModel!.text}',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 10.sp,
            ),
            if (postModel!.postImage != '')
              Container(
                width: double.infinity,
                height: 400.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: NetworkImage('${postModel!.postImage}'),
                      fit: BoxFit.cover),
                ),
              ),
            SizedBox(
              height: 15.h,
            ),
            CommentAndLikeSection(postModel: postModel, comments: comments),
          ],
        ),
      ),
    );
  }
}
