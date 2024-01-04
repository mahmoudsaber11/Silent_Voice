import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/features/create_post/data/models/post_model.dart';

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
                '${model.time}',
                style: TextStyle(fontSize: 12.sp),
              )
            ],
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        IconButton(
          onPressed: () {
            SocialCubit.get(context).removePostImage();
          },
          icon: Icon(
            Icons.more_horiz,
            size: 20.sp,
          ),
        )
      ],
    );
  }
}
