import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/functions/show_toast.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/features/create_post/presentation/widgets/appbar_post_view.dart';
import 'package:social_app/features/create_post/presentation/widgets/user_name_and_image.dart';
import 'package:social_app/features/home/data/models/post_model.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';
import 'package:social_app/features/home/presentation/cubit/post_state.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({
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
  final TextEditingController _textController = TextEditingController();
  String postText = '';
  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) => _controlFeedsState(state, context),
      builder: (context, state) {
        final cubit = BlocProvider.of<PostCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBarPostView(
                  cubit: cubit,
                  postText: postText,
                ),
                CustomCardApp(
                  widget: Column(
                    children: [
                      if (state is CreatePostLoading ||
                          state is UploadPostLoading)
                        const LinearProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      if (state is CreatePostLoading ||
                          state is UploadPostLoading)
                        const SizedBox(
                          height: 10.0,
                        ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          children: [
                            const UserNameAndImage(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  postText = value;
                                });
                              },
                              controller: _textController,
                              decoration: const InputDecoration(
                                  hintText: 'what is on your mind ...',
                                  border: InputBorder.none),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (cubit.postImage != null)
                              Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      height: 400.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          image: DecorationImage(
                                              image:
                                                  FileImage(cubit.postImage!),
                                              fit: BoxFit.cover)),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cubit.removePostImage();
                                      },
                                      icon: CircleAvatar(
                                          backgroundColor: Colors.grey[400],
                                          radius: 13,
                                          child: Icon(
                                            Icons.close,
                                            size: 16,
                                            color: Colors.grey[300],
                                          )),
                                    ),
                                  ]),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<PostCubit>(context)
                                    .getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.image,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5.0.w,
                                  ),
                                  const Text(
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
                            const Text(
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

  void _controlFeedsState(PostState state, BuildContext context) {
    if (state is CreatePostSuccess) {
      _textController.clear();
      setState(() {
        postText = '';
      });
    }

    if (state is CreatePostError) {
      showToast(text: state.error, state: ToastStates.error);
    }

    if (state is UploadPostError) {
      showToast(text: state.error, state: ToastStates.error);
    }
  }
}
