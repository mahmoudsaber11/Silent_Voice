import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/comment/presentation/widgets/build_comment_input_section.dart';
import 'package:social_app/features/comment/presentation/widgets/comment_list_view.dart';
import 'package:social_app/features/comment/presentation/widgets/comment_app_bar.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/comment/presentation/widgets/no_comments.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/features/comment/data/models/comment_model.dart';

class CommentView extends StatelessWidget {
  final String? postId;
  final String? postUid;
  final int? likes;
  CommentView({Key? key, this.postId, this.postUid, this.likes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? postId = this.postId;
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getComments(postId);
        LayoutCubit.get(context).getUserData();

        return BlocBuilder<SocialCubit, SocialStates>(
            builder: (context, state) {
          List<CommentModel> comments = SocialCubit.get(context).comments;
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CommentAppBar(comments: comments),
                  CustomCardApp(
                      widget: Column(
                    children: [
                      comments.isNotEmpty
                          ? CommentListView(comments: comments)
                          : NoComments(),
                      BuildCommentInputSection(
                        postId: postId,
                      )
                    ],
                  )),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
