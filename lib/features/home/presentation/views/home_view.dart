import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/functions/show_toast.dart';
import 'package:social_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/features/home/presentation/widgets/appbar_home_view.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
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
            UserModel? userModel = SocialCubit.get(context).userModel;
            if (userModel != null) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) => CustomPostItem(
                                model: SocialCubit.get(context).posts[index],
                                userModel: userModel,
                              )),
                          separatorBuilder: ((context, index) => SizedBox(
                                height: 12.h,
                              )),
                          itemCount: SocialCubit.get(context).posts.length),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              );
            } else if (state is SocialGetUserErrorStates) {
              return showToast(text: state.error, state: ToastStates.error);
            } else {
              return Center(child: const CustomCircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
