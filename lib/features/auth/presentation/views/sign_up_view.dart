import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/features/auth/presentation/widgets/sign_up/sign_up_form.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
              child: Text("Create Account", style: AppTextStyles.textStyle20),
            ),
            SizedBox(
              height: 35.h,
            ),
            CustomCardApp(
                widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
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
                        "Create Account to keep exploring amazing\ndestinations around the world!",
                        style: AppTextStyles.textStyle15,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  const SignUpForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppTextStyles.textStyle15
                            .copyWith(color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () => context.getBack(),
                          child: Text(
                            "Sign in",
                            style: AppTextStyles.textStyle15
                                .copyWith(color: AppColors.primaryColor),
                          ))
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
