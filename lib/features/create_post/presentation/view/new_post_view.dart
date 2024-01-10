import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/create_post/presentation/widgets/appbar_post_view.dart';
import 'package:social_app/features/create_post/presentation/widgets/custom_card_create_post.dart';
import 'package:social_app/features/home/data/models/post_model.dart';

class NewPostView extends StatefulWidget {
  NewPostView({
    super.key,
    this.postId,
    this.postModel,
  });
  final String? postId;
  final PostModel? postModel;

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final TextEditingController textController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBarPostView(
                  textController: textController,
                ),
                CustomCardApp(
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
                        textController: textController,
                      ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
