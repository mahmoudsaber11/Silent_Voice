import 'package:equatable/equatable.dart';

abstract class SingInState extends Equatable {
  const SingInState();
  @override
  List<Object?> get props => [];
}

class SignInInitial extends SingInState {
  const SignInInitial();
}

class SignInChangePasswordVisibility extends SingInState {
  final bool isPassword;

  const SignInChangePasswordVisibility({required this.isPassword});

  @override
  List<Object?> get props => [isPassword];
}

class SignInLoading extends SingInState {
  const SignInLoading();
}

class SignInSuccess extends SingInState {
  final String uId;

  const SignInSuccess({required this.uId});
  @override
  List<Object?> get props => [uId];
}

class SignInError extends SingInState {
  final String error;

  const SignInError(this.error);
  @override
  List<Object?> get props => [error];
}
