import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_color.dart';

class CustomSendButton extends StatelessWidget {
  const CustomSendButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
          width: 50.w,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12.r)),
          child: Center(
            child: Image.asset(
              AppAssets.iconSend,
              width: 28.w,
              color: Colors.white,
            ),
          )),
    );
  }
}
