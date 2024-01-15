import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_text_style.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
  });
  final void Function()? onTap;
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: AppColors.primaryColor,
          margin: const EdgeInsets.all(10.0),
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(children: [
            Image.asset(
              image,
              height: 205.h,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  title,
                  style:
                      AppTextStyles.textStyle25.copyWith(color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
