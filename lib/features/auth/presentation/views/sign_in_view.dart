import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/features/auth/presentation/widgets/sign_in/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Access Hub", style: AppTextStyles.textStyle20),
            ),
            SizedBox(
              height: 35.h,
            ),
            CustomCardApp(
                widget: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: AppTextStyles.textStyle30
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "login now to communicate with friends",
                      style: AppTextStyles.textStyle15,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                const SignInForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: AppTextStyles.textStyle15
                          .copyWith(color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () =>
                            context.navigateTo(routeName: Routes.signUpRoute),
                        child: Text(
                          "Sign up",
                          style: AppTextStyles.textStyle15
                              .copyWith(color: AppColors.primaryColor),
                        ))
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
