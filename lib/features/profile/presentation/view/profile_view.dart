import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/custom_count_info.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/custom_sign_out_button.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/user_profile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 40.h, bottom: 30.h),
          child: Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    'Back',
                    style: AppTextStyles.textStyle16
                        .copyWith(color: AppColors.primaryColor),
                  )
                ],
              ),
              const Spacer(),
              const CustomSignOutButtom(),
            ],
          ),
        ),
        const UserProfile(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0.h),
          child: const Row(
            children: [
              CustomCountInfo(
                text: "Following",
                count: "256",
              ),
              CustomCountInfo(
                text: "Followers",
                count: "45K",
              ),
              CustomCountInfo(
                text: "Post",
                count: "100",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
