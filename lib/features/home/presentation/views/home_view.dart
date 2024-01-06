import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/home/presentation/widgets/appbar_home_view.dart';
import 'package:social_app/features/home/presentation/widgets/custom_post_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
        ),
        AppbarHomeView(),
        BlocBuilder<SocialCubit, SocialStates>(
          builder: (context, state) {
            return Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) => CustomPostItem(
                        postModel: SocialCubit.get(context).posts[index],
                      )),
                  separatorBuilder: ((context, index) => SizedBox(
                        height: 12.h,
                      )),
                  itemCount: SocialCubit.get(context).posts.length),
            );
          },
        ),
      ],
    );
  }
}
