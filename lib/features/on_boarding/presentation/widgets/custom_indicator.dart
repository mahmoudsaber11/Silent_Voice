import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/core/utils/app_color.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          right: 25.w,
          top: MediaQuery.sizeOf(context).height * .84,
          left: 20.w),
      child: SmoothPageIndicator(
        controller: pageController,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.primaryColor,
          dotHeight: size.height * 0.01.h,
          expansionFactor: size.width * 0.01.w,
          dotWidth: size.width * 0.02.w,
          spacing: size.width * 0.015.w,
        ),
      ),
    );
  }
}
