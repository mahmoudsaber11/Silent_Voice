import 'package:flutter/material.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:social_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:social_app/features/layout/social_layout.dart';
import 'package:social_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:social_app/splash/presentation/views/splash_view.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case Routes.onBoardingViewRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());

      case Routes.signInRoute:
        return MaterialPageRoute(builder: (context) => const SignInView());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (context) => SignUpView());

      case Routes.LayoutViewRoute:
        return MaterialPageRoute(builder: (context) => SocialLayout());

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
