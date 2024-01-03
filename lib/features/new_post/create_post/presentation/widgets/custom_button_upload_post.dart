import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';

class CustomButtonUploadPost extends StatelessWidget {
  const CustomButtonUploadPost({
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
    return TextButton(
        onPressed: () {
          if (SocialCubit.get(context).postImage == null) {
            SocialCubit.get(context).createPost(
              name: socialUserModel.name,
              postText: textController.text,
              date: now.toString(),
            );
          } else {
            SocialCubit.get(context).uploadPost(
                postText: textController.text, date: now.toString());
          }
        },
        child: Text(
          'Post',
          style: AppTextStyles.textStyle16.copyWith(color: Colors.white60),
        ));
  }
}
