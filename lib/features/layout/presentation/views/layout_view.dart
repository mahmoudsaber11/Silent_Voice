import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_assets.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_state.dart';

class MediaXLayout extends StatelessWidget {
  const MediaXLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          body: cubit.views()[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            selectedItemColor: Colors.white,
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeBottomNav(value, context);
            },
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.iconHome,
                  width: 25.w,
                  color: Colors.white,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppAssets.iconMessage,
                    color: Colors.white,
                    width: 30.w,
                  ),
                  label: "Message"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppAssets.iconServices,
                    width: 30.w,
                    color: Colors.white,
                  ),
                  label: "Services"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    AppAssets.iconProfile,
                    color: Colors.white,
                    width: 30.w,
                  ),
                  label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
