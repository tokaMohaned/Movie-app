import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/popular_widget.dart';
import '../../widgets/up_coming_widget.dart';
import '../../widgets/top_rated_widget.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "HomeScreen";

  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const PopularWidget(),
          SizedBox(
            height: 30.h,
          ),
          const TopRatedWidget(),
          SizedBox(
            height: 30.h,
          ),
          const UpComingWidget(),
        ],
      ),
    );
  }
}
