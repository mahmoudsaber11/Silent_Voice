import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/functions/show_toast.dart';
import 'package:social_app/core/widgets/custom_general_button.dart';
import 'package:social_app/core/widgets/custom_text_field.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_state.dart';

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
  late final GlobalKey<FormState> _formKey;

  void _initFormAttributes() {
    _formKey = GlobalKey<FormState>();
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
  }

  void _disposeControllers() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) => _handleSignUpState(state, context),
      builder: (context, state) {
        return Form(
            key: _formKey,
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
                      controller: _nameController),
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
                      controller: _emailController),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                      validate: (String? value) =>
                          Helper.validatePasswordField(value),
                      prefix: Icon(
                        Icons.lock_outline,
                        color: Colors.grey[400],
                      ),
                      hintText: "Enter password",
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
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
                      controller: _confirmController),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomGeneralButton(text: "Create Account", onPressed: () {})
                ],
              ),
            ));
      },
    );
  }

  void _handleSignUpState(SignUpState state, BuildContext context) {
    if (state is SignUpSuccess) {
      _handleSuccessState(context);
    }
    if (state is SignUpError) {
      showToast(text: state.error, state: ToastStates.error);
    }
  }

  void _handleSuccessState(BuildContext context) {
    CacheHelper.saveData(key: 'uid', value: Helper.uId).then((value) {
      if (value) {
        context.navigateAndReplacement(newRoute: Routes.LayoutViewRoute);
      }
    });
  }
}
