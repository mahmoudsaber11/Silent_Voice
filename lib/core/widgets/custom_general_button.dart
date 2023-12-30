import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });

  final String text;
  final double? width;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Text(
              text,
              style: AppTextStyles.textStyle16,
            ),
            Spacer(),
            Icon(
              Icons.arrow_right_outlined,
              color: Colors.white,
              size: 35.w,
            )
          ],
        ),
      ),
    );
  }
}
