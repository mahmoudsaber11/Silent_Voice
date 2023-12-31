// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_app/core/helpers/helper.dart';
// import 'package:social_app/core/utils/functions/show_toast.dart';
// import 'package:social_app/features/auth/data/repositories/sign_in/sign_in_repo_impl.dart';
// import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
// import 'package:social_app/features/auth/presentation/cubits/sign_in/sign_in_state.dart';
// import 'package:social_app/features/auth/presentation/views/sign_up_view.dart';
// import 'package:social_app/features/layout/cubit/cubit.dart';
// import 'package:social_app/features/layout/social_layout.dart';
// import 'package:social_app/shared/components/components.dart';
// import 'package:social_app/shared/components/constants.dart';
// import 'package:social_app/core/helpers/cache_helper.dart';

// class SignInView extends StatelessWidget {
//   const SignInView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var emailController = TextEditingController();
//     var passwordController = TextEditingController();
//     var formKey = GlobalKey<FormState>();
//     return BlocProvider(
//       create: (BuildContext context) => SignInCubit(SignInRepoImpl()),
//       child: BlocConsumer<SignInCubit, SingInState>(
//         listener: (context, state) {
//           if (state is SignInError) {
//             showToast(text: state.error, state: ToastStates.error);
//           }

// if (state is SignInSuccess) {
//   CacheHelper.saveData(
//     key: 'uId',
//     value: state.uId,
//   ).then((value) async {
//     SocialCubit.get(context).getUserData(Helper.uId);
//     showToast(
//       text: 'Welcome in Social App',
//       state: ToastStates.success,
//     );
//     navigateAndFinish(context, const SocialLayout());
//     SocialCubit.get(context).currentIndex = 0;
//   });
// }
//         },
//         builder: (context, state) {
//           return Scaffold(
//               body: AnnotatedRegion<SystemUiOverlayStyle>(
//             value: SystemUiOverlayStyle.dark,
//             child: Container(
//               height: double.infinity,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFF1f1f1f),
//                     Color(0xFF141414),
//                     Color(0xFF0d0d0d),
//                     Color(0xFF0a0a0a),
//                   ],
//                   stops: [0.1, 0.4, 0.7, 0.9],
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Center(
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Form(
//                             key: formKey,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'LOGIN',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headlineMedium!
//                                       .copyWith(
//                                         color: Colors.deepOrange,
//                                       ),
//                                 ),
//                                 Text(
//                                   'login now to communicate with friends',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge!
//                                       .copyWith(color: Colors.orange),
//                                 ),
//                                 const SizedBox(
//                                   height: 30,
//                                 ),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   decoration: bxDecorationStyle,
//                                   child: TextFormField(
//                                     validator: (value) {
//                                       if (value!.isEmpty ||
//                                           !value.contains('@')) {
//                                         return 'please enter your email address';
//                                       }
//                                       return null;
//                                     },
//                                     controller: emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     style: const TextStyle(
//                                       color: Colors.orange,
//                                     ),
//                                     decoration: const InputDecoration(
//                                         border: OutlineInputBorder(),
//                                         labelText: 'Email Address',
//                                         labelStyle: lblStyle,
//                                         prefixIcon: Icon(
//                                           Icons.email,
//                                           color: Colors.deepOrange,
//                                         )),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15.0,
//                                 ),
//                                 Container(
//                                   height: 70,
//                                   alignment: Alignment.centerLeft,
//                                   decoration: bxDecorationStyle,
//                                   child: TextFormField(
//                                     controller: passwordController,
//                                     keyboardType: TextInputType.visiblePassword,
//                                     style: const TextStyle(
//                                       color: Colors.orange,
//                                     ),
//                                     decoration: InputDecoration(
//                                       suffix: IconButton(
//                                         onPressed: () {
//                                           SignInCubit.get(context)
//                                               .changePasswordVisibility();
//                                         },
//                                         icon: Icon(
//                                           Icons.visibility,
//                                           color: Colors.deepOrange,
//                                         ),
//                                       ),
//                                       border: const OutlineInputBorder(),
//                                       labelText: 'Password',
//                                       labelStyle: lblStyle,
//                                       prefixIcon: const Icon(
//                                         Icons.lock,
//                                         color: Colors.deepOrange,
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'Invalid password!';
//                                       }
//                                       return null;
//                                     },
//                                     obscureText:
//                                         SignInCubit.get(context).isPassword,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 ConditionalBuilder(
//                                   condition: state is! SignInLoading,
//                                   builder: (context) {
//                                     return defaultButton(
//                                       function: (() {
//                                         if (formKey.currentState!.validate()) {
//                                           SignInCubit.get(context).userLogin(
//                                               email: emailController.text,
//                                               password:
//                                                   passwordController.text);
//                                         }
//                                       }),
//                                       text: 'login',
//                                     );
//                                   },
//                                   fallback: (context) => const Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Don\'t have an account?',
//                                       style: TextStyle(color: Colors.orange),
//                                     ),
//                                     TextButton(
//                                         onPressed: () {
//                                           navigateTo(context, SignUpView());
//                                         },
//                                         // navigateTo(context, ShopRegisterScreen());
//                                         //},
//                                         child: const Text('REGISTER'))
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ));
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/core/utils/app_text_style.dart';
import 'package:social_app/core/widgets/custom_card_app.dart';
import 'package:social_app/features/auth/presentation/widgets/sign_in/sign_in_form.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Text("Access Hub", style: AppTextStyles.textStyle20),
          ),
          SizedBox(
            height: 35.h,
          ),
          CustomCardApp(
              widget: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style:
                        AppTextStyles.textStyle30.copyWith(color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "login now to communicate with friends",
                    style: AppTextStyles.textStyle15,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              const SignInForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style:
                        AppTextStyles.textStyle15.copyWith(color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () =>
                          context.navigateTo(routeName: Routes.signUpRoute),
                      child: Text(
                        "Sign up",
                        style: AppTextStyles.textStyle15
                            .copyWith(color: AppColors.primaryColor),
                      ))
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
