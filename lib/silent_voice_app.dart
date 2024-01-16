import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/config/routes/app_router.dart';
import 'package:social_app/config/themes/app_themes.dart';
import 'package:social_app/features/comment/data/repositories/comment_repo_impl.dart';
import 'package:social_app/features/comment/presentation/cubit/comment_cubit.dart';
import 'package:social_app/features/home/data/repositories/post_repo_impl.dart';
import 'package:social_app/features/home/presentation/cubit/post_cubit.dart';
import 'package:social_app/features/layout/data/repositories/layout_repo_impl.dart';
import 'package:social_app/features/layout/presentation/cubit/layout_cubit.dart';

//
class SilentVoice extends StatelessWidget {
  const SilentVoice({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit(layoutRepo: LayoutRepoImpl())
            ..getUserData()
            ..getAllUsers(),
        ),
        BlocProvider(
            create: (context) => CommentCubit(commentRepo: CommentRepoImpl())),
        BlocProvider(
            create: (context) =>
                PostCubit(postRepo: PostRepoImpl())..getPosts())
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: MyTheme.lightTheme,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
