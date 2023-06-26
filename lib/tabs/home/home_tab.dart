import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/widgets/add_movie.dart';
import '../../api/network/remot/api_manager.dart';
import '../../constants/constants.dart';
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
          FutureBuilder<PopularResponse>(
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
              PopularResponse movie = snapshot.data!;
              return Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    height: 280.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          "$baseImageUrl/original/${movie.results!.first.backdropPath!}",
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
                  SizedBox(
                    height: 150.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Image.network(
                                "$baseImageUrl/original/${movie.results!.first.posterPath!}",
                                // fit: BoxFit.cover,
                              ),
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
                                movie.results!.first.title!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    movie.results!.first.releaseDate!,
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  const Icon(Icons.star,color: Colors.amberAccent,size: 13,),
                                  Text(
                                    movie.results!.first.voteAverage!.toString(),
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
          const Recommended()
        ],
      ),
    );
  }
}
