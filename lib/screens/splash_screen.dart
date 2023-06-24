import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/bottom_navigation_bar.dart';


class SplashScreen extends StatefulWidget {
  static const String routeName="SplashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
          ()=>Navigator.pushReplacementNamed(context, BottomNavgationBar.routeName),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Color(0xff121312) ,
      body: Center(
        child: Container(
          child:
          Image(image: AssetImage("assets/images/movies.png"),
          ),

        ),
      ), );
  }
}
