import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/app_router.dart';
import 'package:social_app/config/themes/app_themes.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/features/layout/cubit/cubit.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
            create: ((BuildContext context) => SocialCubit()
              ..getUserData(Helper.uId)
              ..getPosts()
              ..getUsers())),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: AppCubit.get(context).isDarkMode
                    ? ThemeMode.light
                    : ThemeMode.dark,
                theme: MyTheme.lightTheme,
                darkTheme: MyTheme.darkTheme,
                onGenerateRoute: AppRouter.onGenerateRoute,
              ),
            );
          }),
    );
  }
}
