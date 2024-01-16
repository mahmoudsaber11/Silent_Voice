import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_divider.dart';
import 'package:social_app/features/home/data/models/post_model.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';
import 'package:social_app/features/home/presentation/widgets/custom_icon_likes.dart';

class CommentAndLikeSection extends StatelessWidget {
  const CommentAndLikeSection({
    super.key,
    required this.postModel,
  });

  final PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomIconsLikes(
              text: "${postModel!.likes}",
            ),
            const Spacer(),
            Icon(
              Icons.comment_outlined,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
            SizedBox(
              width: 4.w,
            ),
            StreamBuilder(
              stream: commentStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot<Map<String, dynamic>> commentsSnapshot =
                      snapshot.data!;
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> comments =
                      commentsSnapshot.docs;
                  return Text(
                    "${comments.length} Comments",
                    style: TextStyle(fontSize: 12.sp),
                  );
                } else {
                  return const Text("0");
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        const CustomDivider(),
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage('${Helper.userModel!.image}'),
            ),
            SizedBox(
              width: 10.w,
            ),
            InkWell(
              onTap: () {
                context.navigateTo(
                    routeName: Routes.commentsViewRoute,
                    arguments: postModel!.postId);
              },
              child: Text(
                'Write a comment ....',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                await BlocProvider.of<PostCubit>(context)
                    .likedByMe(postModel!.postId);
              },
              child: const CustomIconsLikes(
                text: "Like",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> commentStream() {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel!.postId)
        .collection("comments")
        .orderBy('dateTime')
        .snapshots();
  }
}
