import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../api/network/remot/api_manager.dart';
import '../constants/constants.dart';
import '../models/popular_response.dart';
import '../screens/movie_details.dart';
import 'add_movie.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PopularResponse>(
      future: ApiManager.getPopular(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
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
        } if ( snapshot.data == null) {
          return Image.asset("assets/images/loading.png");
        }
        PopularResponse movie = snapshot.data!;
        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              height: 280.w,
              child: GestureDetector(
                onTap: (){
                  String movieId = "${movie.results!.first.id}";
                  print("movieId : $movieId");
                 Navigator.pushNamed(context, MovieDetails.routeName, arguments: movieId);
                },
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
    );
  }
}
