import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';

class CustomCardCreatePost extends StatelessWidget {
  const CustomCardCreatePost({
    super.key,
    required this.textController,
  });
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PostCubit>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${Helper.userModel!.image}'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text('${Helper.userModel!.name}'),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
                hintText: 'what is on your mind ...', border: InputBorder.none),
          ),
          const SizedBox(
            height: 20.0,
          ),
          if (cubit.postImage != null)
            Stack(alignment: AlignmentDirectional.topEnd, children: [
              Container(
                height: 400.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                        image: FileImage(cubit.postImage!), fit: BoxFit.cover)),
              ),
              IconButton(
                onPressed: () {
                  cubit.removePostImage();
                },
                icon: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    radius: 13,
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey[300],
                    )),
              ),
            ]),
        ],
      ),
    );
  }
}
