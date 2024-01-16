import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static final darkTheme = ThemeData(
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: const Color(0xff333739),
      appBarTheme: const AppBarTheme(
        titleSpacing: 20.0,
        // ignore: deprecated_member_use
        //  backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff333739),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Color(0xff333739),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          fontFamily: 'Jannah',
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor: Color(0xff333739),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.5),
      ),
      fontFamily: 'Jannah');
}
