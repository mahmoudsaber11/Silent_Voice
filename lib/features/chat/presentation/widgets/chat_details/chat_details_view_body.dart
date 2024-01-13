import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/core/widgets/custom_messanger_and_comment_field.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/appbar_chat_details.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/chat_buble.dart';

class ChatDetailsViewBody extends StatefulWidget {
  const ChatDetailsViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ChatDetailsViewBody> createState() => _ChatDetailsViewBodyState();
}

class _ChatDetailsViewBodyState extends State<ChatDetailsViewBody> {
  final TextEditingController messangerConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarChatDetails(userModel: widget.userModel),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: CustomCardApp(
            widget: Column(
              children: [
                // Expanded(
                //     child: ListView.builder(
                //         itemBuilder: ((context, index) => ChatBuble()))),
                ChatBuble(),
                ChatBubleForFriend(),
                CustomMessangerAndCommentField(
                    controller: messangerConroller,
                    hintText: 'Send Message...',
                    prefix: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_enhance_outlined,
                        )),
                    onPressed: () {}),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
