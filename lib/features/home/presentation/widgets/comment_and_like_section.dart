import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_divider.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/features/comment/presentation/view/comment_view.dart';
import 'package:social_app/features/create_post/data/models/post_model.dart';
import 'package:social_app/features/home/presentation/widgets/custom_icon_likes.dart';
import 'package:social_app/models/social_app/comment_model.dart';
import 'package:social_app/shared/components/components.dart';

class CommentAndLikeSection extends StatelessWidget {
  const CommentAndLikeSection({
    super.key,
    required this.postModel,
    required this.comments,
  });

  final PostModel? postModel;
  final List<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomIconsLikes(
              text: "${postModel!.likes}",
            ),
            Spacer(),
            Icon(
              Icons.comment_outlined,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              "${comments.length} Comments",
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        CustomDivider(),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                navigateTo(
                  context,
                  CommentView(
                    likes: postModel!.likes,
                    postId: postModel!.postId,
                    postUid: postModel!.uId,
                  ),
                );
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage('${Helper.userModel!.image}'),
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
            InkWell(
              onTap: () async {
                await SocialCubit.get(context).likedByMe(
                    postUser: Helper.userModel,
                    context: context,
                    postModel: postModel,
                    postId: postModel!.postId);
              },
              child: CustomIconsLikes(
                text: "Like",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
