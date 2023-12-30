import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/core/widgets/custom_general_button.dart';
import 'package:social_app/features/on_boarding/presentation/widgets/custom_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) => CustomPageView(),
              ),
              Positioned(
                top: 50.0.h,
                right: 20.0.w,
                child: Text("Skip", style: AppTextStyles.textStyle16),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
          child: CustomGeneralButton(text: "Next", onPressed: () {}),
        )
      ],
    );
  }
}
