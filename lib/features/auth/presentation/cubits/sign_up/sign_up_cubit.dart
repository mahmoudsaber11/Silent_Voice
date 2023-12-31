import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/data/repositories/sign_up/sign_up_repo.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.signUpRepo}) : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);
  SignUpRepo signUpRepo;
  void signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SignUpLoading());
    signUpRepo
        .signUp(name: name, email: email, password: password, phone: phone)
        .then((value) {
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(SignUpError(error: error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    signUpRepo
        .createUser(name: name, email: email, phone: phone, uId: uId)
        .then((value) {
      emit(CreateUserSuccess());
      emit(SignUpSuccess(uId: uId));
    }).catchError((error) {
      emit(CreateUserError(error: error.toString()));
    });
  }

  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    emit(SignUpChangePasswordVisibility(isPassword: isPassword));
  }
}
