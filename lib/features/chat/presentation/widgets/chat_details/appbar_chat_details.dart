import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/custom_button_call.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/call_video.dart';
import 'package:social_app/features/chat/presentation/widgets/chat_details/nlp.dart';
import 'package:social_app/shared/components/components.dart';

class AppBarChatDetails extends StatelessWidget {
  const AppBarChatDetails({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context.getBack();
                  },
                  icon: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      Text(
                        'Back',
                        style: AppTextStyles.textStyle16,
                      )
                    ],
                  )),
              Text(
                "Chat",
                style: AppTextStyles.textStyle20,
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.white,
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${userModel.image}',
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userModel.name}',
                      style: AppTextStyles.textStyle16Bold
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      '${userModel.bio}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              CustomButtonCall(
                icon: Icons.call_outlined,
                onPressed: () => navigateTo(context, SpeechScreen()),
              ),
              SizedBox(
                width: 7.w,
              ),
              CustomButtonCall(
                onPressed: () => navigateTo(context, CallPage(callID: '1')),
                icon: Icons.videocam_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
