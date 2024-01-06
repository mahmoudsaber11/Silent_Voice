import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/custom_edit_button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 70.h,
        left: 30.w,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 64,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage("${Helper.userModel!.image}"),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Helper.userModel!.name}',
                style: AppTextStyles.textStyle20.copyWith(color: Colors.black),
              ),
              Text(
                '${Helper.userModel!.bio}',
                style: AppTextStyles.textStyle15,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomEditButton(),
            ],
          )
        ],
      ),
    );
  }
}