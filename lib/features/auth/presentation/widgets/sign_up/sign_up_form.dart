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
import 'package:social_app/features/auth/data/repositories/sign_up/sign_up_repo_impl.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_state.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _confirmPassFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

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
    _nameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _phoneController.dispose();
  }

  void _disposeFocusNodes() {
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPassFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(signUpRepo: SignUpRepoImpl()),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) => _handleSignUpState(state, context),
        builder: (context, state) {
          SignUpCubit cubit = BlocProvider.of<SignUpCubit>(context);
          return Form(
              key: _formKey,
              autovalidateMode: autovalidateMode,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  children: [
                    CustomTextField(
                      validate: (String? value) =>
                          Helper.validateUserNameField(value),
                      prefix: Icon(
                        Icons.person_outlined,
                        color: Colors.grey[400],
                      ),
                      hintText: "Enter your name",
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      autofillHints: <String>[AutofillHints.name],
                      focusNode: _nameFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
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
                        autofillHints: <String>[AutofillHints.email],
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                        isPassword: cubit.isPassword,
                        suffix: IconButton(
                          onPressed: () => cubit.switchPassVisibility(),
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
                        hintText: "Enter password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        autofillHints: <String>[AutofillHints.password],
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_confirmPassFocusNode)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                        isPassword: cubit.isConfirmPassVisible,
                        suffix: IconButton(
                          onPressed: () => cubit.switchConfirmPassVisibility(),
                          icon: Icon(
                            cubit.isConfirmPassVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        validate: (String? value) =>
                            Helper.validateConfirmPasswordField(
                              value: value,
                              password: _passwordController.text,
                              confirmPassword: _confirmController.text,
                            ),
                        prefix: Icon(
                          Icons.lock_outline,
                          color: Colors.grey[400],
                        ),
                        hintText: "Enter confirm password",
                        keyboardType: TextInputType.visiblePassword,
                        controller: _confirmController,
                        focusNode: _confirmPassFocusNode,
                        autofillHints: <String>[AutofillHints.password],
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_phoneFocusNode)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid phone!';
                        }
                        return null;
                      },
                      prefix: Icon(
                        Icons.phone,
                        color: Colors.grey[400],
                      ),
                      hintText: "Phone Number",
                      onSubmit: (String val) => _signUp(context),
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      autofillHints: <String>[AutofillHints.photo],
                      focusNode: _phoneFocusNode,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    state is SignUpLoading
                        ? const CustomCircularProgressIndicator()
                        : CustomGeneralButton(
                            text: "Create Account",
                            onPressed: () => _signUp(context))
                  ],
                ),
              ));
        },
      ),
    );
  }

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Helper.keyboardUnfocus(context);
      BlocProvider.of<SignUpCubit>(context).signUp(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          phone: _phoneController.text);
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
  }

  void _handleSignUpState(SignUpState state, BuildContext context) {
    if (state is SignUpSuccess) {
      _handleSuccessState(context, state);
    }
    if (state is SignUpError) {
      showToast(text: state.error, state: ToastStates.error);
    }
  }

  void _handleSuccessState(BuildContext context, SignUpSuccess state) {
    CacheHelper.saveData(key: 'uid', value: state.uId).then((value) {
      if (value) {
        CacheHelper.saveData(
          key: 'uId',
          value: state.uId,
        ).then((value) async {
          BlocProvider.of<LayoutCubit>(context).getUserData();
          showToast(
            text: 'Welcome in Silent Voice',
            state: ToastStates.success,
          );
          context.navigateAndReplacement(newRoute: Routes.LayoutViewRoute);
        });
      }
    });
  }
}
