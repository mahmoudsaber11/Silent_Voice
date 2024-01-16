import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/config/routes/routes.dart';
import 'package:social_app/core/helpers/cache_helper.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_navigator.dart';

class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  void navigateTo() {
    Helper.uId = CacheHelper.getStringData(key: 'uId');
    bool? onBoarding = CacheHelper.getBoolData(key: 'onBoarding');
    if (onBoarding != null) {
      if (Helper.uId != null) {
        context.navigateAndRemoveUntil(newRoute: Routes.layoutViewRoute);
      } else {
        context.navigateAndReplacement(newRoute: Routes.signInRoute);
      }
    } else {
      context.navigateAndReplacement(newRoute: Routes.onBoardingViewRoute);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigateTo();
    });
    super.initState();
  }

  void _setSystemUIOverlayStyle() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    final double bottomPadding = View.of(context).viewPadding.bottom;

    // Set the color based on the presence of the system navigation bar
    final Color systemNavigationBarColor =
        bottomPadding > 0 ? Colors.black : Colors.transparent;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavigationBarColor,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _setSystemUIOverlayStyle();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
