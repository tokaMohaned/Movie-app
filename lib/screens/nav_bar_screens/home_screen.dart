import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/widget/popular_movie.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName="HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Popular_movie();

  }
}
