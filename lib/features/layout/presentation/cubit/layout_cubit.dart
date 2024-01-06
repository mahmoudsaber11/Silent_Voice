import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/layout/data/repositories/layout_repo.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit({required this.layoutRepo}) : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of(context);
  final LayoutRepo layoutRepo;
  var currentIndex = 0;

  void changeBottomNav(int index, context) {
    layoutRepo.changeBottomNav(index: index, context: context);
    emit(ChangeBottomNavState(index));
  }

  List<Widget> views() {
    return layoutRepo.views();
  }

  void getUserData() {
    emit(GetUserDataLoading());
    layoutRepo.getUserData().then((value) {
      Helper.userModel = UserModel.fromJson(value.data());
      emit(GetUserDataSuccess(user: Helper.userModel!));
      print(Helper.userModel);
    }).catchError((error) {
      emit(GetUserDataError(error: error.toString()));
    });
  }
}
