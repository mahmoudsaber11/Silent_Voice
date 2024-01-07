import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/widgets/custom_button.dart';
import 'package:social_app/cubit/cubit.dart';

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

  @override
  void initState() {
    _initFormAttributes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: TextFormField(
                controller: commentTextControl,
                autofocus: true,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Write something!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  hintText: "Add a comment...",
                  hintStyle: TextStyle(color: Colors.grey[300]),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage('${Helper.userModel!.image}'),
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 50.w,
                    child: CustomButton(
                      onPressed: () => _getTextAndImage(context),
                    ),
                  ),
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getTextAndImage(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      SocialCubit.get(context).commentPost(
        postId: widget.postId,
        comment: commentTextControl.text,
        time: TimeOfDay.now().format(context),
      );
    } else {
      SocialCubit.get(context).uploadCommentPic(
        postId: widget.postId,
        commentText:
            commentTextControl.text == '' ? null : commentTextControl.text,
        time: TimeOfDay.now().format(context),
      );
    }
    commentTextControl.clear();
  }
}
