import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat/presentation/views/chat_details_view.dart';
import 'package:social_app/shared/components/components.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ChatDetailsView(
              userModel: userModel,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Row(children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${userModel.image}')),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${userModel.name}", style: AppTextStyles.textStyle16Bold)
            ],
          ),
          const SizedBox(
            width: 3,
          ),
        ]),
      ),
    );
  }
}
