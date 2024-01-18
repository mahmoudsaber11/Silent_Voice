import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/comment/presentation/cubit/comment_cubit.dart';
import 'package:social_app/features/comment/presentation/cubit/comment_state.dart';
import 'package:social_app/features/comment/presentation/widgets/build_comment_input_section.dart';
import 'package:social_app/features/comment/presentation/widgets/comment_list_view.dart';
import 'package:social_app/features/comment/presentation/widgets/comment_app_bar.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/features/comment/presentation/widgets/no_comments.dart';

class CommentView extends StatelessWidget {
  final String? postId;
  const CommentView({
    super.key,
    required this.postId,
  });
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      BlocProvider.of<CommentCubit>(context).getComments(postId: postId!);
      return BlocBuilder<CommentCubit, CommentsState>(
          builder: (context, state) {
        final cubit = BlocProvider.of<CommentCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Column(
            children: [
              CommentAppBar(comments: cubit.comments),
              Expanded(
                child: CustomCardApp(
                    widget: Column(
                  children: [
                    cubit.comments.isNotEmpty
                        ? Expanded(
                            child: CommentListView(comments: cubit.comments))
                        : const Expanded(
                            child: SingleChildScrollView(child: NoComments())),
                    BuildCommentInputSection(
                      postId: postId,
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                )),
              ),
            ],
          ),
        );
      });
    });
  }
}
