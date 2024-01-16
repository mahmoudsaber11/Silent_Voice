import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:social_app/features/on_boarding/presentation/widgets/custom_indicator.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.pageInfo,
    required this.pageController,
  });
  final OnBoardingModel pageInfo;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
              image: DecorationImage(
                  image: AssetImage(
                    pageInfo.image,
                  ),
                  fit: BoxFit.cover)),
        ),
        Positioned(
            bottom: 50.h,
            left: 30.w,
            right: 0,
            child: Text(pageInfo.title, style: AppTextStyles.textStyle30)),
        Visibility(
          visible: true,
          child: Positioned(
            top: size.height * .07.h,
            right: size.width * .06.w,
            child: IconButton(
                onPressed: () {
                  context.navigateAndReplacement(newRoute: Routes.signInRoute);
                },
                icon: Text("Skip", style: AppTextStyles.textStyle16)),
          ),
        ),
        Positioned(
          right: 0,
          left: 10.w,
          bottom: 20.h,
          child: CustomIndicator(
            pageController: pageController,
          ),
        )
      ],
    );
  }
}
