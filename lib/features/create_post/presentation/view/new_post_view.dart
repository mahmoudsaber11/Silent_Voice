import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/create_post/presentation/widgets/appbar_post_view.dart';
import 'package:social_app/features/create_post/presentation/widgets/custom_card_create_post.dart';
import 'package:social_app/features/create_post/data/models/post_model.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';

class NewPostView extends StatelessWidget {
  NewPostView({
    super.key,
    this.postId,
    this.postModel,
  });
  final TextEditingController textController = TextEditingController();
  final now = TimeOfDay.now();
  final String? postId;
  final PostModel? postModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(
      builder: (context, state) {
        UserModel userModel = SocialCubit.get(context).userModel!;
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Column(
            children: [
              AppBarPostView(
                  socialUserModel: userModel,
                  textController: textController,
                  now: now),
              Expanded(
                child: CustomCardApp(
                  widget: Column(
                    children: [
                      if (state is SocialCreatePostLoadingState)
                        const LinearProgressIndicator(),
                      if (state is SocialCreatePostLoadingState)
                        const SizedBox(
                          height: 10.0,
                        ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomCardCreatePost(
                          socialUserModel: userModel,
                          textController: textController),
                      Spacer(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                SocialCubit.get(context).getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5.0.w,
                                  ),
                                  Text(
                                    'add photo',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Text(
                              '# tags',
                              style: TextStyle(color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
