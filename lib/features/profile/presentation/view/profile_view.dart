import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/custom_count_info.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialStates>(builder: (context, state) {
      var userModel = SocialCubit.get(context).userModel;
      var cubit = SocialCubit.get(context);
      return Column(
        children: [
          UserProfile(userModel: userModel),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0.h),
            child: Row(
              children: [
                CustomCountInfo(
                  text: "Following",
                  count: "256",
                ),
                CustomCountInfo(
                  text: "Followers",
                  count: "45K",
                ),
                CustomCountInfo(
                  text: "Post",
                  count: "100",
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Column(
          //     children: [
          //       Container(
          //         width: double.infinity,
          //         padding: const EdgeInsets.all(10),
          //         height: 60,
          //         child: InkWell(
          //           onTap: () {
          //             SocialCubit.get(context).signOut(context);
          //           },
          //           child: const Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Icon(
          //                 Icons.power_settings_new,
          //                 size: 20,
          //                 color: Colors.deepOrange,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 'SignOut',
          //                 style: TextStyle(fontSize: 15),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ConditionalBuilder(
                    condition: cubit.users!.isNotEmpty,
                    builder: (context) {
                      return StoriesUserItem(userModel: cubit.users![index]);
                    },
                    fallback: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
                itemCount: cubit.users!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 14.w,
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}

class StoriesUserItem extends StatelessWidget {
  const StoriesUserItem({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Colors.grey[300],
      child: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage("${userModel.image}"),
      ),
    );
  }
}
