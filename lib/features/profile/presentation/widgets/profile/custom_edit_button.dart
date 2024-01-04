import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(8.w)),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
                    color: AppColors
                        .primaryColor) // Change to your desired border color
                ),
            backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor)),
        onPressed: () {
          context.navigateTo(routeName: Routes.editProfileViewRoute);
        },
        child: Text(
          "Edit",
          style: AppTextStyles.textStyle16,
        ));
  }
}
