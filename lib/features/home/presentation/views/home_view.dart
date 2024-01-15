import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/functions/show_toast.dart';
import 'package:social_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';
import 'package:social_app/features/home/presentation/cubit/post_state.dart';
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
        const AppbarHomeView(),
        BlocConsumer<PostCubit, PostState>(
          listener: (context, state) => _controlFeedsState(state),
          builder: (context, state) {
            final cubit = BlocProvider.of<PostCubit>(context);
            if (state is GetPostsSuccess) {
              return Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: ((context, index) => CustomPostItem(
                          postModel: cubit.posts[index],
                        )),
                    separatorBuilder: ((context, index) => SizedBox(
                          height: 12.h,
                        )),
                    itemCount: cubit.posts.length),
              );
            } else if (state is GetPostsError) {
              return showToast(text: state.error, state: ToastStates.error);
            } else {
              return const Center(child: CustomCircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  void _controlFeedsState(PostState state) {
    if (state is DeletePostSuccess) {
      showToast(
        text: 'Post deleted successfully',
        state: ToastStates.success,
      );
    }
  }
}
