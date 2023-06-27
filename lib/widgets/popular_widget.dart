import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/provider/my_app_provider.dart';
import 'package:untitled1/widgets/widgets.dart';

import '../api/network/remot/api_manager.dart';
import '../constants/constants.dart';
import '../models/popular_response.dart';
import '../screens/movie_details.dart';
import 'add_movie.dart';
import 'movie_added.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
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
                onPressed: () {},
                child: const Text("Try Again"),
              )
            ],
          );
        }
        if (snapshot.data == null) {
          return Image.asset("assets/images/loading.png");
        }
        PopularResponse movie = snapshot.data!;
        String movieId = "${movie.results!.first.id}";
        Results result = movie.results!.first;
        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
              height: 280.w,
              child: GestureDetector(
                onTap: () {
                  nextScreen(
                      context, MovieDetails(movieId: movieId, movie: result));
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
                        ),
                        if (provider.isMovieInWatchList(movie.results!.first))
                          MovieAdded(result: movie.results!.first)
                        else
                          AddMovie(result: movie.results!.first)
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
                              fontWeight: FontWeight.bold),
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
                            const Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                              size: 13,
                            ),
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
