import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.onBoarding1,
                    ),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            top: 50.0.h,
            right: 20.0.w,
            child: Text("Skip", style: AppTextStyles.textStyle16),
          ),
          Positioned(
              bottom: 55.h,
              left: 25.w,
              child: Container(
                width: MediaQuery.sizeOf(context).width * .8,
                child: Text("Welcome To the Fun Media X",
                    style: AppTextStyles.textStyle30),
              ))
        ],
      ),
    );
  }
}
