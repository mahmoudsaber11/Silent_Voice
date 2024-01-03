import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconsLikes extends StatelessWidget {
  const CustomIconsLikes({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.favorite,
          size: 22.sp,
          color: Colors.red,
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
