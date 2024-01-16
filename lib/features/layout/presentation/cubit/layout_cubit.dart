import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/layout/data/repositories/layout_repo.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit({required this.layoutRepo}) : super(const LayoutInitial());
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

  void getUserData() {
    emit(const GetUserDataLoading());
    layoutRepo.getUserData().then((value) {
      Helper.userModel = UserModel.fromJson(value.data());
      emit(GetUserDataSuccess(user: Helper.userModel!));
    }).catchError((error) {
      emit(GetUserDataError(error: error.toString()));
    });
  }

  List<UserModel>? users;
  void getAllUsers() {
    emit(const GetAllUsersLoading());
    users = [];
    layoutRepo.getAllUsers().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != Helper.userModel!.uId) {
          users!.add(UserModel.fromJson(element.data()));
        }
      }
      emit(GetAllUserSuccess(users: users!));
    }).catchError((error) {
      emit(GetUserDataError(error: error));
    });
  }

  dynamic signOut(BuildContext context) async {
    await CacheHelper.removeData(
      key: 'uId',
    ).then((value) {
      if (value) {
        context.navigateAndReplacement(newRoute: Routes.signInRoute);
        LayoutCubit.get(context).currentIndex = 0;
      }
    });
  }

  void changeCurrentIndexToZero() {
    currentIndex = 0;
    emit(ChangeBottomNavState(currentIndex));
  }
}
