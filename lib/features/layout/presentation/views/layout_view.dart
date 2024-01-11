import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message_outlined,
                    size: 25,
                  ),
                  label: "Message"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.label_important_outline,
                    size: 30,
                  ),
                  label: "Services"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outlined,
                    size: 30,
                  ),
                  label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}
