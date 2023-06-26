import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/widgets/add_movie.dart';
import '../../models/popular_response.dart';
import '../../widgets/new_release_widget.dart';
import '../../widgets/recommended_widget.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "HomeScreen";

  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FutureBuilder<Results>(
            future: ApiManager.getPopular(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || snapshot.data == null) {
                return Column(
                  children: [
                    const Text("Something went wrong"),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text("Try Again"),
                    )
                  ],
                );
              }
              final movie = snapshot.data!;
              return Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    height: 280.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          movie.backdropPath!,
                          fit: BoxFit.cover,
                        ),
                        const Icon(
                          Icons.play_circle,
                          size: 90,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 2.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Image.asset("assets/images/side_image.png"),
                            const AddMovie(),
                          ],
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              movie.title!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              "${movie.releaseDate}  PG-13  2h 7m",
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 30.h,
          ),
          const NewReleaseWidget(),
          SizedBox(
            height: 30.h,
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFF282A28),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recommended",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return const Recommended();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 14.w,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
