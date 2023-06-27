import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../provider/my_app_provider.dart';
import '../widgets/add_movie.dart';
import '../widgets/more_like_this_widget.dart';
import '../widgets/movie_added.dart';

class MovieDetails extends StatelessWidget {
  static const String routeName = "MovieDetails";
  String? movieId;
  var movie;

  MovieDetails({super.key, required this.movieId, required this.movie});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAppProvider>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                "$baseImageUrl/original/${movie.backdropPath!}",
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Text(
              movie.title!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            child: Row(
              children: [
                Text(
                  movie.releaseDate!,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  width: 8.h,
                ),
                Text(
                  movie.voteAverage!.toString(),
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "$baseImageUrl/original/${movie.posterPath!}",
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      provider.isMovieInWatchList(movie)
                          ? MovieAdded(result: movie)
                          : AddMovie(result: movie)
                     // AddMovie(result: movie),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.h,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border:
                                Border.all(color: Colors.white60, width: 2)),
                        child: const Text(
                          "Type",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                          child: Text("${movie.overview}",
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white))),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 20,
                          ),
                          SizedBox(width: 10.h),
                          Text("${movie.voteAverage}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MoreLikeThisWidget(
            movieId: movieId,
          )
        ],
      ),
    );
  }
}
