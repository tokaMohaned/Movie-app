import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_movie.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.topLeft,
      children: [
        Card(
          color: const Color(0xFF343534),
          shape: Border.all(),
          elevation: 100,
          child: Column(
            children: [
              Image.asset("assets/images/new_releases.png"),
              Padding(
                padding: EdgeInsets.symmetric( vertical: 5.h),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star,color: Colors.amberAccent,size: 15,),
                        Text("7.7", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    SizedBox(
                      height: 3.w,
                    ),
                    const Text("Deadpool 2", style: TextStyle(color: Colors.white),),
                    SizedBox(
                      height: 3.w,
                    ),
                    Text("2018  R  1h 59m", style: TextStyle(color: Colors.white,fontSize: 8.sp),),
                  ],
                ),
              ),
            ],
          ),
        ),
        const AddMovie()
      ],
    );
  }
}
