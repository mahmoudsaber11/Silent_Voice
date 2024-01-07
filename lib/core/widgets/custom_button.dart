import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(8),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
      ),
      onPressed: onPressed,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(310 / 360),
        child: Icon(
          Icons.send_rounded,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
