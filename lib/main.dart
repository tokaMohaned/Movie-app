import 'package:flutter/material.dart';
import 'package:untitled1/MyTheme.dart';
import 'package:untitled1/screens/bottom_navigation_bar.dart';
import 'package:untitled1/screens/nav_bar_screens/home_screen.dart';
import 'package:untitled1/screens/nav_bar_screens/search.dart';
import 'package:untitled1/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThmemData.themeData,

      initialRoute: SplashScreen.routeName,
      routes:{
        SplashScreen.routeName:(context)=>SplashScreen(),
        BottomNavgationBar.routeName:(context)=>BottomNavgationBar(),

        HomeScreen.routeName:(context)=>HomeScreen(),
        SearchTab.routeName:(context)=>SearchTab(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

