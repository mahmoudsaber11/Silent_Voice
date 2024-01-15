import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/Home/presentation/views/home_view.dart';
import 'package:social_app/features/chat/presentation/views/chat_view.dart';
import 'package:social_app/features/layout/data/repositories/layout_repo.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:social_app/features/other_services/view/other_services_view.dart';
import 'package:social_app/features/profile/presentation/view/profile_view.dart';

class LayoutRepoImpl implements LayoutRepo {
  @override
  void changeBottomNav({required int index, required context}) {
    BlocProvider.of<LayoutCubit>(context).currentIndex = index;
  }

  @override
  List<Widget> views() {
    return [
      const HomeView(),
      const ChatView(),
      const OtherServicesView(),
      const ProfileView(),
    ];
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Helper.uId)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }
}
