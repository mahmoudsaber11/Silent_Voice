import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/models/social_app/post_model.dart';

class CustomProfileCreatePost extends StatelessWidget {
  const CustomProfileCreatePost({
    super.key,
    required this.model,
  });

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            '${model.image}',
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${model.name}',
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 16.sp,
                  )
                ],
              ),
              Text(
                '${model.date}',
                style: TextStyle(fontSize: 12.sp),
              )
            ],
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_horiz,
            size: 20.sp,
          ),
        )
      ],
    );
  }
}
