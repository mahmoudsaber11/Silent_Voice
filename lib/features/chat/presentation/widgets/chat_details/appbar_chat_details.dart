import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/core/widgets/custom_app_bar.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';

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
          const CustomAppBar(
            title: "Chat",
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
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              // CustomButtonCall(icon: Icons.mic_outlined, onPressed: () {}
              //     // context.navigateTo(routeName: Routes.speechScreenRoute),
              //     ),
              // SizedBox(
              //   width: 7.w,
              // ),
              // CustomButtonCall(
              //   onPressed: () =>
              //       context.navigateTo(routeName: Routes.callPageRoute),
              //   icon: Icons.videocam_outlined,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
