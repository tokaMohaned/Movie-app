import 'package:flutter/material.dart';
import 'package:untitled1/shared/my_theme.dart';
import 'package:untitled1/splash/splash_screen.dart';

import 'home_layout/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemeData.themeData,
      initialRoute: SplashScreen.routeName,
      routes:{
        SplashScreen.routeName:(context)=>const SplashScreen(),
        HomeLayout.routeName:(context)=>const HomeLayout(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

