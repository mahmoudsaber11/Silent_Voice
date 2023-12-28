import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String error;

  const SignUpError({required this.error});

  @override
  List<Object> get props => [error];
}

class CreateUserSuccess extends SignUpState {
  final String uId;

  CreateUserSuccess({required this.uId});

  @override
  List<Object?> get props => [uId];
}

class CreateUserError extends SignUpState {
  final String error;

  const CreateUserError({required this.error});

  @override
  List<Object> get props => [error];
}

class SignUpChangePasswordVisibility extends SignUpState {
  final bool isPassword;

  SignUpChangePasswordVisibility({required this.isPassword});

  @override
  List<Object?> get props => [isPassword];
}
