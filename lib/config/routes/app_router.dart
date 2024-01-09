import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/features/auth/data/repositories/sign_up/sign_up_repo_impl.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:social_app/features/create_post/presentation/view/new_post_view.dart';
import 'package:social_app/features/layout/presentation/views/layout_view.dart';
import 'package:social_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:social_app/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:social_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:social_app/features/profile/presentation/view/edit_profile_view.dart.dart';
import 'package:social_app/splash/presentation/views/splash_view.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case Routes.onBoardingViewRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    OnBoardingCubit(onBoardingRepo: OnBoardingRepoImpl()),
                child: const OnBoardingView()));

      case Routes.signInRoute:
        return MaterialPageRoute(builder: (context) => const SignInView());

      case Routes.signUpRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => SignUpCubit(signUpRepo: SignUpRepoImpl()),
                child: SignUpView()));

      case Routes.LayoutViewRoute:
        return MaterialPageRoute(builder: (context) => MediaXLayout());

      case Routes.postViewRoute:
        return MaterialPageRoute(builder: (context) => NewPostView());

      // case Routes.commentsViewRoute:
      //   final args = routeSettings.arguments as CommentsViewParams;
      //   return MaterialPageRoute(
      //       builder: (context) => CommentView(
      //         likes: ,
      //           ));

      case Routes.editProfileViewRoute:
        return MaterialPageRoute(builder: (context) => EditProfileView());

      default:
        return _unFoundRoute();
    }
  }

  static Route<dynamic> _unFoundRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            "Un Found Route",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
