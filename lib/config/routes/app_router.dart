import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/features/auth/data/models/user_model.dart';
import 'package:social_app/features/auth/data/repositories/sign_up/sign_up_repo_impl.dart';
import 'package:social_app/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:social_app/features/chat/presentation/views/chat_details_view.dart';
import 'package:social_app/features/comment/presentation/view/comment_view.dart';
import 'package:social_app/features/create_post/presentation/view/new_post_view.dart';
import 'package:social_app/features/layout/presentation/views/layout_view.dart';
import 'package:social_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:social_app/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:social_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:social_app/features/profile/data/repositories/edit_profile_repo_impl.dart';
import 'package:social_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:social_app/features/profile/presentation/view/edit_profile_view.dart.dart';
import 'package:social_app/features/splash/presentation/views/splash_view.dart';

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
                child: const SignUpView()));

      case Routes.layoutViewRoute:
        return MaterialPageRoute(builder: (context) => const MediaXLayout());

      case Routes.commentsViewRoute:
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => CommentView(
                  postId: args,
                ));

      case Routes.postViewRoute:
        return MaterialPageRoute(builder: (context) => const NewPostView());

      case Routes.editProfileViewRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    EditProfileCubit(editProfileRepo: EditProfileRepoImpl()),
                child: const EditProfileView()));

      // case Routes.speechScreenRoute:
      //   return MaterialPageRoute(builder: (context) => const SpeechScreen());

      // case Routes.callPageRoute:
      //   return MaterialPageRoute(
      //       builder: (context) => const CallPage(callID: '1'));

      case Routes.chatDetailsViewRoute:
        final args = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => ChatDetailsView(userModel: args));

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
