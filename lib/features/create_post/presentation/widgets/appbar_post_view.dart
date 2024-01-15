import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/home/data/entities/post_params.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';

class AppBarPostView extends StatelessWidget {
  const AppBarPostView({
    super.key,
    required this.cubit,
    required this.postText,
  });

  final PostCubit cubit;
  final String postText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 55.h, left: 10.w, right: 10.w, bottom: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                context.getBack();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              )),
          Text(
            "Create New Post",
            style: AppTextStyles.textStyle20,
          ),
          TextButton(
              onPressed: () {
                if (cubit.postImage == null) {
                  cubit.createNewPost(
                    postParams: PostParams(
                      date: Helper.getDate(),
                      time: DateFormat.jm().format(DateTime.now()),
                      text: postText,
                    ),
                  );
                } else {
                  cubit.uploadPost(
                    postParams: PostParams(
                      date: Helper.getDate(),
                      time: DateFormat.jm().format(DateTime.now()),
                      text: postText,
                    ),
                  );
                }
              },
              child: Text(
                'Post',
                style:
                    AppTextStyles.textStyle16.copyWith(color: Colors.white60),
              )),
        ],
      ),
    );
  }

  // void _createNewPost(BuildContext context) {
  //   if (cubit.postImage == null && postText.isNotEmpty) {
  //     cubit.createNewPost(
  //       postParams: PostParams(
  //         date: Helper.getDate(),
  //         time: DateFormat.jm().format(DateTime.now()),
  //         text: postText,
  //       ),
  //     );
  //   } else if (cubit.postImage != null) {
  //     cubit.uploadPost(
  //       postParams: PostParams(
  //         date: Helper.getDate(),
  //         time: DateFormat.jm().format(DateTime.now()),
  //         text: postText,
  //       ),
  //     );
  //   }
  // }
}
