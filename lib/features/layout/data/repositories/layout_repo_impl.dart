import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chats/chats_screen.dart';
import 'package:social_app/features/feeds/feeds_screen.dart';
import 'package:social_app/features/layout/data/repositories/layout_repo.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/features/new_post/new_post_screen.dart';
import 'package:social_app/features/other_services/other_services_screens.dart';
import 'package:social_app/features/settings/settings_screen.dart';

class LayoutRepoImpl implements LayoutRepo {
  @override
  void changeBottomNav({required int index, required context}) {
    BlocProvider.of<LayoutCubit>(context).currentIndex = index;
  }

  @override
  List<Widget> views() {
    return [
      const FeedsScreen(),
      NewPostScreen(),
      const OtherServices(),
      const ProfileScreen(),
    ];
  }
}
