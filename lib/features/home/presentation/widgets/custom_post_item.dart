import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/comment/presentation/view/comment_view.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/core/widgets/custom_divider.dart';
import 'package:social_app/features/home/presentation/widgets/custom_profile_create_post.dart';
import 'package:social_app/features/create_post/data/models/post_model.dart';
import 'package:social_app/shared/components/components.dart';

class CustomPostItem extends StatelessWidget {
  final PostModel model;
  final UserModel userModel;
  const CustomPostItem({
    super.key,
    required this.model,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
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
            CustomProfileCreatePost(model: model),
            SizedBox(
              height: 15.h,
            ),
            Text(
              '${model.text}',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              height: 10.sp,
            ),
            if (model.postImage != '')
              Container(
                width: double.infinity,
                height: 400.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover),
                ),
              ),
            SizedBox(
              height: 15.h,
            ),
            CustomDivider(),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                      context,
                      CommentView(
                        // likes: model.likes,
                        //  postId: model.postId,
                        postUid: model.uId,
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Write a comment ....',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    UserModel? postUser = SocialCubit.get(context).userModel;
                    await SocialCubit.get(context).likedByMe(
                      postUser: postUser,
                      context: context,
                      postModel: model,
                      //    postId: model.postId
                    );
                  },
                  // child: CustomIconsLikes(
                  //   text: "${model.likes}",
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
