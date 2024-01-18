import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class NoComments extends StatelessWidget {
  const NoComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .1.h,
        ),
        Image.asset(
          AppAssets.noComment,
          width: double.infinity,
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          "Be the first to comment",
          style:
              AppTextStyles.textStyle20.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
    // return CustomCardApp(
    //   image: const DecorationImage(
    //       image: AssetImage("assets/images/noComment.jpg")),
    //   widget: Align(
    //       alignment: Alignment.bottomCenter,
    //       child: Padding(
    //         padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).size.height * .1),
    //         child: Text(
    //           "Be the first to comment",
    //           style: AppTextStyles.textStyle20
    //               .copyWith(color: AppColors.primaryColor),
    //         ),
    //       )),
    // );
  }
}
