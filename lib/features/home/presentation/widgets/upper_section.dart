import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/features/home/data/models/post_model.dart';

class UpperSection extends StatelessWidget {
  const UpperSection({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            '${postModel.image}',
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
                    '${postModel.name}',
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
                '${postModel.date} at ${postModel.time} ',
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
            BlocProvider.of<SocialCubit>(context)
                .deletePost(postId: postModel.postId!);
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
