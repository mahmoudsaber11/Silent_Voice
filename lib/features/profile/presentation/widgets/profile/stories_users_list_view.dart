import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/profile/presentation/widgets/profile/stories_user_item.dart';

class StoriesUsersListView extends StatelessWidget {
  const StoriesUsersListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    return BlocBuilder<SocialCubit, SocialStates>(
      builder: (context, state) {
        return SizedBox(
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
        );
      },
    );
  }
}
