import 'package:equatable/equatable.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';

abstract class LayoutState extends Equatable {
  const LayoutState();
  @override
  List<Object?> get props => [];
}

class LayoutInitial extends LayoutState {
  const LayoutInitial();
}

class ChangeBottomNavState extends LayoutState {
  final int index;

  ChangeBottomNavState(this.index);
  @override
  List<Object?> get props => [index];
}

class GetUserDataLoading extends LayoutState {
  const GetUserDataLoading();
}

class GetUserDataSuccess extends LayoutState {
  final UserModel user;

  const GetUserDataSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserDataError extends LayoutState {
  final String error;

  const GetUserDataError({required this.error});

  @override
  List<Object> get props => [error];
}
