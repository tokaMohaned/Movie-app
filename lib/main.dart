import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/provider/my_app_provider.dart';
import 'package:untitled1/shared/my_theme.dart';
import 'package:untitled1/screens/splash_screen.dart';

import 'home_layout/home_layout.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => MyAppProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  late MyAppProvider provider;

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getPreferences();
    provider = Provider.of<MyAppProvider>(context);
    return MaterialApp(
      theme: MyThemeData.themeData,
      home: const SplashScreen(),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeLayout.routeName: (context) => const HomeLayout(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  void getPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchListString = prefs.getStringList('watch_list');
    if (watchListString != null) {
      provider.watchList = watchListString.map((json) => jsonDecode(json)).toList();
    }
  }
}
