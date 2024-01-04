import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/create_post/presentation/widgets/custom_button_upload_post.dart';

class AppBarPostView extends StatelessWidget {
  const AppBarPostView({
    super.key,
    required this.socialUserModel,
    required this.textController,
    required this.now,
  });

  final UserModel socialUserModel;
  final TextEditingController textController;
  final TimeOfDay now;

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
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              )),
          Text(
            "Create New Post",
            style: AppTextStyles.textStyle20,
          ),
          CustomButtonUploadPost(
              socialUserModel: socialUserModel,
              textController: textController,
              now: now)
        ],
      ),
    );
  }
}
