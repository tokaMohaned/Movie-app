import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/api/network/remot/api_manager.dart';
import '../constants/constants.dart';
import '../models/movie_details_response.dart';
import '../widgets/add_movie.dart';
import '../widgets/more_like_this_widget.dart';

class MovieDetails extends StatelessWidget {
  static const String routeName = "MovieDetails";
  String? movieId;
  var movie;

  MovieDetails({super.key, required this.movieId, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: ApiManager.getMovieDetails(movieId!),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Try Again"),
                )
              ],
            ),
          );
        }
        MovieDetailsResponse movieDetails = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  "$baseImageUrl/original/${movieDetails.backdropPath!}",
                  fit: BoxFit.cover,
                ),
                const Icon(
                  Icons.play_circle,
                  size: 90,
                  color: Colors.white,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieDetails.title!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Text(
                        movieDetails.releaseDate!.substring(0, 4),
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 17.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Vote Average: ${movieDetails.voteAverage!}",
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 17.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "$baseImageUrl/original/${movieDetails.posterPath!}",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            AddMovie(result: movie)
                            // AddMovie(result: movie),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15.h,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 110,
                              child: GridView.builder(
                                itemCount: movieDetails.genres?.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 10,
                                      childAspectRatio: 6/2
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.w, vertical: 5.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                              color: Colors.white60, width: 2)),
                                      child: Center(
                                        child: Text(
                                          movieDetails.genres?[index].name ??
                                              "",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13.sp),
                                        ),
                                      ));
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                                child: Text("${movieDetails.overview}",
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        const TextStyle(color: Colors.white))),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                  size: 20,
                                ),
                                SizedBox(width: 10.h),
                                Text("${movieDetails.voteAverage}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MoreLikeThisWidget(
              movieId: movieDetails.id.toString(),
            )
          ],
        );
      },
    ));
  }
}
