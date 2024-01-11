import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/features/layout/data/repositories/layout_repo.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_state.dart';
import 'package:social_app/shared/components/components.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit({required this.layoutRepo}) : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of(context);
  final LayoutRepo layoutRepo;
  var currentIndex = 0;

  void changeBottomNav(int index, context) {
    currentIndex = index;
    layoutRepo.changeBottomNav(index: index, context: context);
    if (currentIndex == 1 || currentIndex == 2) {
      getAllUsers();
    }

    emit(ChangeBottomNavState(index));
  }

  List<Widget> views() {
    return layoutRepo.views();
  }

  Future<void> getUserData() async {
    emit(const GetUserDataLoading());
    layoutRepo.getUserData().then((value) {
      Helper.userModel = UserModel.fromJson(value.data());
      emit(GetUserDataSuccess(user: Helper.userModel!));
      print(Helper.userModel);
    }).catchError((error) {
      emit(GetUserDataError(error: error.toString()));
    });
  }

  List<UserModel>? users;
  void getAllUsers() {
    emit(GetAllUsersLoading());
    users = [];
    layoutRepo.getAllUsers().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != Helper.userModel!.uId) {
          users!.add(UserModel.fromJson(element.data()));
        }
      });
      emit(GetAllUserSuccess(users: users!));
    }).catchError((error) {
      emit(GetUserDataError(error: error));
    });
  }

  dynamic signOut(context) async {
    await CacheHelper.removeData(
      key: 'uId',
    ).then((value) {
      if (value) {
        navigateAndFinish(context, const SignInView());
        LayoutCubit.get(context).currentIndex = 0;
      }
    });
  }
}
