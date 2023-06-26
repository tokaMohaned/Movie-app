import 'package:flutter/material.dart';
import 'package:untitled1/shared/app_colors.dart';

class MyThemeData {
  static ThemeData themeData = ThemeData(
      scaffoldBackgroundColor: const Color(0xFF121312),
      primaryColor: AppColors.yellow,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.yellow,
        selectedLabelStyle: TextStyle(color: AppColors.yellow),
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: TextStyle(color: Colors.white),
      ));
}
