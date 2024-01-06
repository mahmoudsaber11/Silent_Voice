import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';

class CustomButtonUploadPost extends StatelessWidget {
  const CustomButtonUploadPost({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(builder: (context, state) {
      return TextButton(
          onPressed: () {
            if (SocialCubit.get(context).postImage == null) {
              SocialCubit.get(context).createPost(
                  postText: textController.text,
                  date: Helper.getDate(),
                  time: DateFormat.jm().format(DateTime.now()));
            } else {
              SocialCubit.get(context).uploadPost(
                  postText: textController.text,
                  date: Helper.getDate(),
                  time: DateFormat.jm().format(DateTime.now()));
            }
          },
          child: Text(
            'Post',
            style: AppTextStyles.textStyle16.copyWith(color: Colors.white60),
          ));
    });
  }
}
