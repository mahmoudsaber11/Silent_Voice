import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/widgets/custom_general_button.dart';
import 'package:social_app/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:social_app/features/on_boarding/presentation/cubit/on_boarding_state.dart';
import 'package:social_app/features/on_boarding/presentation/widgets/custom_page_item.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        OnBoardingCubit cubit = BlocProvider.of<OnBoardingCubit>(context);
        //    var size = MediaQuery.of(context).size;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: cubit.onBoardingPages().length,
                  itemBuilder: (context, index) => CustomPageView(
                    pageInfo: cubit.onBoardingPages()[index],
                    pageController: pageController,
                  ),
                  onPageChanged: (int index) {
                    cubit.onChangePageIndex(index);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 25.w),
                child: CustomGeneralButton(
                  text: cubit.isLastBoarding ? 'Get Started' : 'Next',
                  onPressed: () => navOnBoarding(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void navOnBoarding(BuildContext context) {
    if (pageController.page! < 2) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      CacheHelper.saveData(key: 'onBoarding', value: true);
      context.navigateAndReplacement(newRoute: Routes.signInRoute);
    }
  }
}
