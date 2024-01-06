import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/custom_count_info.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/stories_users_list_view.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/user_profile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserProfile(),
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
      ],
    );
  }
}