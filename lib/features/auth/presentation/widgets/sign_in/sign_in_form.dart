import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/functions/show_toast.dart';
import 'package:social_app/core/widgets/custom_circular_progress_indicator.dart';
import 'package:social_app/core/widgets/custom_general_button.dart';
import 'package:social_app/core/widgets/custom_text_field.dart';
import 'package:social_app/features/auth/data/repositories/sign_in/sign_in_repo_impl.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_state.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode autovalidateMode;
  void _initFormAttributes() {
    _formKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
  }

  @override
  void initState() {
    _initFormAttributes();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _disposeControllers();
    _disposeFocusNodes();
  }

  void _disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _disposeFocusNodes() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(signInRepo: SignInRepoImpl()),
      child: BlocConsumer<SignInCubit, SingInState>(
        listener: (context, state) => _handleSignInState(state, context),
        builder: (context, state) {
          SignInCubit cubit = BlocProvider.of<SignInCubit>(context);
          return Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                children: [
                  CustomTextField(
                      validate: (String? value) =>
                          Helper.validateEmailField(value),
                      prefix: Icon(
                        Icons.email_outlined,
                        color: Colors.grey[400],
                      ),
                      hintText: "Enter your email address",
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      autofillHints: const <String>[AutofillHints.email],
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode)),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    isPassword: cubit.isPassword,
                    suffix: IconButton(
                      onPressed: () => cubit.changePasswordVisibility(),
                      icon: Icon(
                        cubit.isPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    validate: (String? value) =>
                        Helper.validatePasswordField(value),
                    prefix: Icon(
                      Icons.lock_outline,
                      color: Colors.grey[400],
                    ),
                    onSubmit: (String val) => _signIn(context),
                    hintText: "Enter password",
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    autofillHints: const <String>[AutofillHints.password],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  state is SignInLoading
                      ? const CustomCircularProgressIndicator()
                      : CustomGeneralButton(
                          text: "SIGN IN", onPressed: () => _signIn(context))
                ],
              ));
        },
      ),
    );
  }

  void _signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Helper.keyboardUnfocus(context);
      BlocProvider.of<SignInCubit>(context).signIn(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  void _handleSignInState(SingInState state, BuildContext context) {
    _handleSuccessState(state, context);
    if (state is SignInError) {
      showToast(text: state.error, state: ToastStates.error);
    }
  }

  void _handleSuccessState(SingInState state, BuildContext context) {
    if (state is SignInSuccess) {
      CacheHelper.saveData(
        key: 'uId',
        value: state.uId,
      ).then((value) async {
        Helper.uId = state.uId;
        BlocProvider.of<LayoutCubit>(context).getUserData().then((value) {
          showToast(
            text: 'Welcome in Silent Voice',
            state: ToastStates.success,
          );
          BlocProvider.of<PostCubit>(context).getPosts().then((value) {
            context.navigateAndReplacement(newRoute: Routes.layoutViewRoute);
            BlocProvider.of<LayoutCubit>(context).currentIndex = 0;
          });
        });
      });
    }
  }
}
