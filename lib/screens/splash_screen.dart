import 'dart:async';
import 'package:flutter/material.dart';
import '../home_layout/home_layout.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () =>
          Navigator.pushReplacementNamed(context, HomeLayout.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff121312),
      body: Center(
        child: Image(
          image: AssetImage("assets/images/splash.png"),
        ),
      ),
    );
  }
}
