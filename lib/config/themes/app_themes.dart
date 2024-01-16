import 'package:flutter/material.dart';
import 'package:social_app/core/utils/app_color.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: AppColors.primaryColor,
    ),
  );
}
