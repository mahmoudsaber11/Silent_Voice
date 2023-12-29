import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';
import 'package:social_app/splash/presentation/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;
  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void timer() {
    _timer = Timer(const Duration(seconds: 5), () => navigateTo());
  }

  void navigateTo() {
    Helper.uId = CacheHelper.getStringData(key: 'uId');
    bool? onBoarding = CacheHelper.getBoolData(key: 'onBoarding');
    if (onBoarding != null) {
      if (Helper.uId != null) {
        context.navigateAndRemoveUntil(newRoute: Routes.LayoutViewRoute);
      } else {
        context.navigateAndReplacement(newRoute: Routes.signInRoute);
      }
    } else {
      context.navigateAndReplacement(newRoute: Routes.onBoardingViewRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
