import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';

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
        context.navigateTo(
            routeName: Routes.chatDetailsViewRoute, arguments: userModel);
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
