import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/features/on_boarding/data/models/on_boarding_model.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.pageInfo,
  });
  final OnBoardingModel pageInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Container(
        padding: EdgeInsets.only(
            right: 25.w,
            top: MediaQuery.sizeOf(context).height * .7,
            left: 20.w),
        width: MediaQuery.sizeOf(context).width * .8,
        child: Text(pageInfo.title, style: AppTextStyles.textStyle30),
      ),
    );
  }
}
