import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(8.w)),
            side: MaterialStateProperty.all<BorderSide>(const BorderSide(
                    color: AppColors
                        .primaryColor) // Change to your desired border color
                ),
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor)),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.textStyle16,
        ));
  }
}
