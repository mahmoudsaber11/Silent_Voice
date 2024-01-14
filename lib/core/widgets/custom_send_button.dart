import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      elevation: 0,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(310 / 350),
          child: Icon(
            Icons.send_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
