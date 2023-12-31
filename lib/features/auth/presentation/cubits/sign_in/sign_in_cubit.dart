import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/auth/data/repositories/sign_in/sign_in_repo.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_state.dart';
import 'package:social_app/core/helpers/cache_helper.dart';

class SignInCubit extends Cubit<SingInState> {
  SignInCubit({required this.signInRepo}) : super(SignInInitial());

  final SignInRepo signInRepo;
  static SignInCubit get(context) => BlocProvider.of(context);

  void SignIn({
    required String email,
    required String password,
  }) {
    emit(SignInLoading());
    signInRepo.signIn(email: email, password: password).then((value) {
      CacheHelper.saveData(key: 'uid', value: Helper.uId);
      emit(SignInSuccess(uId: value.user!.uid));
    }).catchError((error) {
      emit(SignInError(error.toString()));
    });
  }
  // void userLogin({
  //   required String email,
  //   required String password,
  // }) async {
  //   emit(SocialLoginLoadingState());
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     String uid = userCredential.user!.uid;

  //     await CacheHelper.saveData(key: 'uid', value: uid);
  //     emit(SocialLoginSuccessState(uid));
  //   } catch (error) {
  //     emit(SocialLoginErrorState(error.toString()));
  //   }
  // }

  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    emit(SignInChangePasswordVisibility(isPassword: isPassword));
  }
}
