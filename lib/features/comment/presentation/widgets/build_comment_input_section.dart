import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/custom_messanger_and_comment_field.dart';
import 'package:social_app/features/comment/data/entities/comment_post_params.dart';
import 'package:social_app/features/comment/presentation/cubit/comment_cubit.dart';

class BuildCommentInputSection extends StatefulWidget {
  const BuildCommentInputSection({
    super.key,
    required this.postId,
  });
  final String? postId;
  @override
  State<BuildCommentInputSection> createState() =>
      _BuildCommentInputSectionState();
}

class _BuildCommentInputSectionState extends State<BuildCommentInputSection> {
  final TextEditingController commentTextControl = TextEditingController();
  late final GlobalKey<FormState> _formKey;
  void _initFormAttributes() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    commentTextControl.dispose();
    super.dispose();
  }

  String commentText = '';
  @override
  void initState() {
    _initFormAttributes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CustomMessangerAndCommentField(
        controller: commentTextControl,
        hintText: "Add a comment...",
        prefix: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('${Helper.userModel!.image}'),
          ),
        ),
        onPressed: () => _getText(context),
      ),
    );
  }

  void _getText(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<CommentCubit>(context).commentPost(
        params: CommentPostParams(
            commentText: commentTextControl.text,
            postId: widget.postId,
            time: TimeOfDay.now().format(context),
            date: Helper.getDate()),
        context: context,
      );
    }
    setState(() {
      commentText = '';
    });
    commentTextControl.clear();
  }
}
