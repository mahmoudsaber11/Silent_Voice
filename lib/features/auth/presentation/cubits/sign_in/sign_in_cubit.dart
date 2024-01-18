import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/data/repositories/sign_in/sign_in_repo.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_state.dart';

class SignInCubit extends Cubit<SingInState> {
  SignInCubit({required this.signInRepo}) : super(const SignInInitial());

  final SignInRepo signInRepo;
  static SignInCubit get(context) => BlocProvider.of(context);

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(const SignInLoading());
    signInRepo.signIn(email: email, password: password).then((value) {
      emit(SignInSuccess(uId: value.user!.uid));
    }).catchError((error) {
      emit(SignInError(error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    emit(SignInChangePasswordVisibility(isPassword: isPassword));
  }
}
