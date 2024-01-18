import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconsLikes extends StatelessWidget {
  const CustomIconsLikes({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/likes.jpg",
          width: 30.w,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }
}
