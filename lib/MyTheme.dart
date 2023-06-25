
import 'dart:ui';

import 'package:flutter/material.dart';

class MyThmemData{
  static const Color yelloColor=Color(0xFFFFBB3B);
  static const Color greyColor=Color(0xFFC6C6C6);
  //static const Color blackColor=Color(0xFFFFBB3B);


static ThemeData themeData=ThemeData(
  primaryColor: yelloColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1A1A1A),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyThmemData.yelloColor,
    selectedLabelStyle: TextStyle(color: MyThmemData.yelloColor),
     unselectedItemColor: MyThmemData.greyColor,
    unselectedLabelStyle: TextStyle(color: MyThmemData.greyColor),
  )

//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//   backgroundColor: Colors.black,
//   type: BottomNavigationBarType.fixed,
//   selectedItemColor: Colors.black,
//   selectedLabelStyle: TextStyle(color: Colors.black),
//   unselectedItemColor: Colors.white,
//   unselectedLabelStyle: TextStyle(color: Colors.white),
// )
);
}