import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/comment/presentation/widgets/comment_list_view.dart';
import 'package:social_app/comment/presentation/widgets/cooment_app_bar.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/social_app/comment_model.dart';

class CommentView extends StatelessWidget {
  final TextEditingController commentTextControl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final String? postId;
  final String? postUid;

  CommentView({Key? key, this.postId, this.postUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? postId = this.postId;
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getComments(postId);
        SocialCubit.get(context).getUserData(postUid!);

        return BlocBuilder<SocialCubit, SocialStates>(
            builder: (context, state) {
          List<CommentModel> comments = SocialCubit.get(context).comments;
          dynamic commentImage = SocialCubit.get(context).commentImage;
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Column(
              children: [
                CommentAppBar(comments: comments),
                CustomCardApp(
                    widget: Column(
                  children: [
                    Expanded(
                      child: comments.isNotEmpty
                          ? CommentListView(comments: comments)
                          : Center(
                              child: Text(
                                "no comments",
                              ),
                            ),
                    ),
                    buildCommentImagePreview(commentImage, context),
                    buildCommentInputSection(
                        context, postId, commentTextControl, commentImage)
                  ],
                )),
              ],
            ),
          );
        });
      },
    );
  }
}

Widget buildCommentImagePreview(dynamic commentImage, context) {
  return commentImage != null
      ? Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 8.0),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.file(
                    commentImage,
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: IconButton(
                      onPressed: () {
                        SocialCubit.get(context).popCommentImage();
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      : const SizedBox.shrink();
}

Widget buildCommentInputSection(BuildContext context, String? postId,
    TextEditingController commentTextControl, dynamic commentImage) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        if (commentImage != null)
          buildCommentImagePreview(commentImage, context),
        TextFormField(
          controller: commentTextControl,
          autofocus: true,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          validator: (value) {
            if (value!.isEmpty) {
              return "Write something to share";
            }
            return null;
          },
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: "Write a comment",
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    SocialCubit.get(context).getCommentImage();
                  },
                  icon: const Icon(
                    Icons.photo,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (commentImage == null) {
                      SocialCubit.get(context).commentPost(
                        postId: postId,
                        comment: commentTextControl.text,
                        time: TimeOfDay.now().format(context),
                      );
                    } else {
                      SocialCubit.get(context).uploadCommentPic(
                        postId: postId,
                        commentText: commentTextControl.text == ''
                            ? null
                            : commentTextControl.text,
                        time: TimeOfDay.now().format(context),
                      );
                    }
                    commentTextControl.clear();
                    SocialCubit.get(context).popCommentImage();
                  },
                  icon: const Icon(
                    Icons.send_outlined,
                  ),
                ),
              ],
            ),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ],
    ),
  );
}

class BuildComment extends StatelessWidget {
  const BuildComment({
    super.key,
    required this.comment,
  });
  final CommentModel comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 25, backgroundImage: NetworkImage('${comment.image}')),
            SizedBox(
              width: 5.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                comment.commentText != null && comment.commentImage != null
                    ?

                    /// If its (Text & Image) Comment
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[500],
                                    borderRadius: BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(10.0.r),
                                      topStart: Radius.circular(10.0.r),
                                      topEnd: Radius.circular(10.0.r),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${comment.name}',
                                      ),
                                      Text(
                                        '${comment.commentText}',
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Container(
                              width: 400.w,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image(
                                  image: NetworkImage(
                                      comment.commentImage!['image']))),
                        ],
                      )
                    : comment.commentImage != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${comment.name}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Image(
                                      image: NetworkImage(
                                          comment.commentImage!['image']))),
                            ],
                          )
                        : comment.commentText != null
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[500],
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(10.0),
                                      topStart: Radius.circular(10.0),
                                      topEnd: Radius.circular(10.0),
                                    )),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${comment.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${comment.commentText}',
                                    ),
                                  ],
                                ))
                            : const SizedBox(
                                height: 0,
                              ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: Text(
                    '${comment.time}',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
